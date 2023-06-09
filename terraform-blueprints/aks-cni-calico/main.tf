resource "azurerm_resource_group" "vnet" {
  name     = var.vnet_resource_group_name
  location = var.location
}

# create acr Container registery
resource "azurerm_container_registry" "acr" {
  name                = "jcacr07062023"
  location            = azurerm_resource_group.vnet.location
  resource_group_name = azurerm_resource_group.vnet.name
  sku                 = "Standard"
  admin_enabled       = false
}

module "aks_network" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.vnet.name
  location            = var.location
  vnet_name           = var.aks_vnet_name
  address_space       = ["10.0.0.0/22"]
  subnets = [
    {
      name : "aks-subnet"
      address_prefixes : ["10.0.0.0/24"]
    }
  ]
}

data "azurerm_kubernetes_service_versions" "current" {
  location       = var.location
  version_prefix = var.kube_version_prefix
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                    = var.cluster_name
  location                = var.location
  kubernetes_version      = data.azurerm_kubernetes_service_versions.current.latest_version
  resource_group_name     = azurerm_resource_group.vnet.name
  dns_prefix              = "aks"
  private_cluster_enabled = false

  default_node_pool {
    name           = "default"
    node_count     = var.nodepool_nodes_count
    vm_size        = var.nodepool_vm_size
    vnet_subnet_id = module.aks_network.subnet_ids["aks-subnet"]
    type           = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }

  linux_profile {
    admin_username = var.admin_username
    ssh_key {
      key_data = var.admin_ssh_key
    }
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "calico"
    service_cidr       = var.network_service_cidr
    dns_service_ip     = var.network_dns_service_ip
    docker_bridge_cidr = var.network_docker_bridge_cidr
  }

  tags = {
    environment = "dev"
  }
}

resource "azurerm_role_assignment" "netcontributor" {
  role_definition_name = "Network Contributor"
  scope                = module.aks_network.subnet_ids["aks-subnet"]
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}

# create role assignment for aks acr pull
resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}