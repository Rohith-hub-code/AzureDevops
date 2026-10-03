resource "azurerm_resource_group" "rg" {
  name     = var.RGname
  location = var.RGlocation
}

resource "azurerm_service_plan" "plan" {
  name                = "myplan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "myapp" {
  name                = "rpapp"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_service_plan.plan.location
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {}
}

