output "vault-image-id" {
  value = "/subscriptions/d9eadbf1-cd33-4831-86ff-6f0ce120d40c/resourceGroups/rg-tf/providers/Microsoft.Compute/images/Vault-image"
  }

output "os-profile" {
  value = azurerm_virtual_machine.vm-vault.os_profile
}

output "public-ip" {
  value = azurerm_network_interface.nic.ip_configuration
}
