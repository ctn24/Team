output "resource_group_name" {
  value = var.nameRG
}

output "Username" {
  value = module.vm.Username
}

output "IP" {
  value = module.vm.IP
}

output "tls_private_key" {
  value     = module.security.tls_private_key
  sensitive = true
}