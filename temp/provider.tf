terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.77.0"
    }
  }

  required_version = ">= 1.15.5"
}

provider "azurerm" {
  features {}
}
