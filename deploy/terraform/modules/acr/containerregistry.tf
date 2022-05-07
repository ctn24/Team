resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = true
}
# # Pull/Push images to acr
# resource "null_resource" "docker_push" {
#   provisioner "local-exec" {
#   command = <<-EOT
#     docker login ${azurerm_container_registry.acr.login_server} 
#     docker push ${azurerm_container_registry.acr.login_server}
#   EOT
#   }
# }