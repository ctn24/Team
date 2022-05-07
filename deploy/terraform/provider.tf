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
    resource_group_name  = "rg-tfstate-westus"
    storage_account_name = "storage00westus00tq9x"
    container_name       = "terraform-state"
    key                  = "CuuazLxEft9iAMNmrIlSt4uSYE5shyCtetXFL/7QuPe/6cq+4ofQHi5/Fx6WquxBEl2BqAnmHhn83HjWcaDyjw=="
    //access_key           = ""
  }
}
