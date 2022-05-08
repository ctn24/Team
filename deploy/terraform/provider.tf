provider "azurerm" {
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.4.0"
    }

  }
  backend "azurerm" {
    resource_group_name  = "rg-infra"
    storage_account_name = "storage00westus"
    container_name       = "terraform-state"
    key                  = "tfbackend.tf"
    //access_key           = ""
  }
}
