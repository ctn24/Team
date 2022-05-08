# Azure GUIDS
variable "subscription_id" {defdefault = null}
variable "client_id" {defdefault = null}
variable "client_secret" {defdefault = null}
variable "tenant_id" {defdefault = null}

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
variable "admin_username" {defdefault = null}
variable "admin_password" {defdefault = null}