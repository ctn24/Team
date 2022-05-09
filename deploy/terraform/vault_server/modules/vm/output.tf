output "Username" {
  value = azurerm_linux_virtual_machine.myterraformvm.admin_username
}

output "IP" {
  value = azurerm_linux_virtual_machine.myterraformvm.public_ip_address
}