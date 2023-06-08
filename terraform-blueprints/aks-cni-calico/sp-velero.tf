# Create Azure AD App Registration
resource "azuread_application" "app_velero" {
  display_name = "sp_velero"
}

# Create Service Principal
resource "azuread_service_principal" "app_velero" {
  application_id = azuread_application.app_velero.application_id
}

# Create Service Principal password
resource "azuread_service_principal_password" "app_velero" {
  service_principal_id = azuread_service_principal.app_velero.id
}

#Reference existing resources
data "azurerm_subscription" "current" {}

###Create Role Assignments for velero sp

#Primary AKS
resource "azurerm_role_assignment" "sp_velero_aks_node_rg" {
  scope                = format("/subscriptions/%s/resourceGroups/%s", data.azurerm_subscription.current.subscription_id, azurerm_kubernetes_cluster.aks.node_resource_group)
  principal_id         = azuread_service_principal.app_velero.object_id
  role_definition_name = "Contributor"
}

resource "azurerm_role_assignment" "sp_velero_backup_storage" {
  scope                = azurerm_storage_account.velero.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.app_velero.object_id
}

resource "azurerm_role_assignment" "sp_velero_backup_storage_key_operator" {
  scope                = azurerm_storage_account.velero.id
  role_definition_name = "Storage Account Key Operator Service Role"
  principal_id         = azuread_service_principal.app_velero.object_id
}

resource "azurerm_role_assignment" "sp_velero_backup_rg" {
  scope                = azurerm_resource_group.vnet.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.app_velero.object_id
}