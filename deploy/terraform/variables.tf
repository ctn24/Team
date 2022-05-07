# Azure GUIDS
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

# Resource Group/Location
variable "location" { default = "westus" }
variable "rg_name" { default = "rg-tf" }

# ACR - Container Registry
variable "acr_name" { default = "acr0tf" }

# Cosmosdb 
variable "cosmos_name" { default = "cosmosdbaccount-tf" }

# AKS
variable "aks_name" { default = "aks-tf" }

# VM - vault
variable "vault_image_name" { default = "Vault-image" }
variable "vm_size" { default = "D4ads_v5" }
variable "admin_username" {}
variable "admin_password" {}

