resource "random_string" "random" {
  length  = 24
  special = false
  upper   = false
}

resource "azurerm_storage_account" "velero" {
  name                     = (var.sa_name == null ? random_string.random.result : var.sa_name)
  resource_group_name      = azurerm_resource_group.vnet.name
  location                 = azurerm_resource_group.vnet.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "dev"
  }

  depends_on = [ azurerm_resource_group.vnet ]
}

resource "azurerm_storage_container" "velero" {
  name                  = "velero"
  storage_account_name  = azurerm_storage_account.velero.name
  container_access_type = "private"
}