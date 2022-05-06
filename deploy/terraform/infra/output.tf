output "rg-name" {
  value = azurerm_resource_group.rg.name
}

output "location" {
  value = var.location
}

output "service-principal" {
  value = azuread_service_principal.example
}