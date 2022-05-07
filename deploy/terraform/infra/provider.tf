terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }

    azurerm = {
      source = "hashicorp/azurerm"
    }

    azuread = {
      source = "hashicorp/azuread"
    }
  }
}

# provider "random" {
# }

provider "azurerm" {
  features {}
}
provider "azuread" {
  features {}
}