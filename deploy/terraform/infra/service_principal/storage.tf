# This file creates in azure centralus a resource group 
# called "rg-<location>"
# And creates an storage account called 'storage00<location>00XXXX'
# with a container called 'terraform', for the tf states.
# Outputs the storage name, and the storage primary and secondary keys
# And creates a "service principal"

resource "azurerm_resource_group" "rg" {
  name     = "rg-tfstate-${var.location}"
  location = var.location
}

resource "random_string" "random" {
  length  = 4
  special = false
  upper   = false
  number  = true
}

resource "azurerm_storage_account" "storagetf" {
  name                     = "storage00${azurerm_resource_group.rg.location}00${random_string.random.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                 = var.container_name
  storage_account_name = azurerm_storage_account.storagetf.name
  depends_on           = [azurerm_storage_account.storagetf]
}

# Create Service Principal

# data "azuread_client_config" "current" {}

# resource "azuread_application" "example" {
#   display_name = "team"
#   owners       = [data.azuread_client_config.current.object_id]
# }

# resource "azuread_service_principal" "example" {
#   application_id               = azuread_application.example.application_id
#   app_role_assignment_required = false
#   owners                       = [data.azuread_client_config.current.object_id]
# }

# resource "azurerm_azuread_application" "app-team" {
#   name = "app-team"
# }

# resource "" "name" {
  
# }

# resource "azurerm_azuread_service_principal" "sp-tf" {
#   application_id = azurerm_azuread_application.app-team.application_id
# }

# resource "azurerm_azuread_service_principal_password" "spp-tf" {
#   service_principal_id = azurerm_azuread_service_principal.sp-tf.id
#   value                = "my0password"
#   end_date             = "2023-01-01T01:02:03Z"
# }

# resource "azurerm_role_assignment" "ra-tf" {
#   scope                = "yourScope"        # the resource id
#   role_definition_name = "Contributor" # such as "Contributor"
#   principal_id         = "your service principal id"
# }

###########################################################################

# resource "azurerm_azuread_application" "acr-app" {
#   name = "acr-app"
# }

# resource "azurerm_azuread_service_principal" "acr-sp" {
#   application_id = "${azurerm_azuread_application.acr-app.application_id}"
# }

# resource "azurerm_azuread_service_principal_password" "acr-sp-pass" {
#   service_principal_id = "${azurerm_azuread_service_principal.acr-sp.id}"
#   value                = "Password12"
#   end_date             = "2022-01-01T01:02:03Z"
# }

# resource "azurerm_role_assignment" "acr-assignment" {
#   scope                = "${azurerm_container_registry.acr.id}"
#   role_definition_name = "Contributor"
#   principal_id         = "${azurerm_azuread_service_principal_password.acr-sp-pass.service_principal_id}"
# }

###########################################################################