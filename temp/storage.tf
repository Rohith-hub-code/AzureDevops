resource "azurerm_resource_group" "rsgroup" {
  name     = var.RGname
  location = var.RGlocation
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storagename
  resource_group_name      = azurerm_resource_group.rsgroup.name
  location                 = azurerm_resource_group.rsgroup.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "mycontainer"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}
