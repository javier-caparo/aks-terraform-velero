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