output "aks_creds" {
  value = "az aks get-credentials --name ${var.cluster_name}  --resource-group ${var.vnet_resource_group_name}"
}

output "aks_node_resource_group" {
  description = "auto-generated resource group which contains the resources for this managed kubernetes cluster"
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}

# Output the Service Principal and password
output "sp_velero" {
  value     = azuread_service_principal.app_velero.id
  sensitive = false
}

output "sp_velero_password" {
  value     = azuread_service_principal_password.app_velero.value
  sensitive = true
}