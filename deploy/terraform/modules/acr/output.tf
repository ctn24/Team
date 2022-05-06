output "admin-usuario" {
  value = azurerm_container_registry.acr.admin_username
}

output "admin-password" {
  value = azurerm_container_registry.acr.admin_password
}

output "acr-url" {
  value = azurerm_container_registry.acr.login_server
}

output "acr-id" {
  value = azurerm_container_registry.acr.id
}