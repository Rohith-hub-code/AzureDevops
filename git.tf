terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.77.0"
   }
}
}

resource "azurerm_resource_group" "Azure_Rg" {
  name     = var.RGname
  location = var.RGlocation
}


