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

# AKS
variable "aks_name" { default = "aks-tf" }

# Vault
variable "vault_address" {default = null}
variable "terraform_token" {default = null}
