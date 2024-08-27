resource "azurerm_service_plan" "frontend-asp" {
  name                = "frontend-asp-prod"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "P1v2"   # Upgrade to a SKU that supports Availability Zones
  zone_balancing_enabled = true  # Enable zone redundancy
  per_site_scaling    = false

  depends_on = [
    azurerm_subnet.frontend-subnet
  ]
}

resource "azurerm_service_plan" "backend-asp" {
  name                = "backend-asp-prod"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "P1v2"   # premium app service plan sku supports Availability Zones
  zone_balancing_enabled = true  # Enable zone redundancy
  per_site_scaling    = false

  depends_on = [
    azurerm_subnet.backend-subnet
  ]
}
