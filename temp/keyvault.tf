data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = var.RGname
  location = var.RGlocation
}

resource "azurerm_key_vault" "myvault" {
  name                = var.mykeyvault
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  purge_protection_enabled   = false
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete"
    ]
  }
}
