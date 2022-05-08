# Azure GUIDS
variable "subscription_id" { default = null }
variable "client_id" { default = null }
variable "client_secret" { default = null }
variable "tenant_id" { default = null }

# Resource Group/Location
variable "rg_location" { default = "westus" }
variable "rg_name" { default = "rg-infra" }

# ACR - Container Registry
variable "acr_name" { default = "acr0tf" }
variable "acr_password" {default = null}

# Cosmosdb 
variable "cosmos_name" { default = "cosmosdbaccount-tf" }

# AKS
variable "aks_name" { default = "aks-tf" }

# VM - vault
variable "vault_image_name" { default = "Vault-image" }
variable "vm_size" { default = "D4ads_v5" }
variable "admin_username" { default = null }
variable "admin_password" { default = null }
