resource "azurerm_container_registry" "container_registry" {
  name                = "acr${var.region}${var.env}${var.purpose}"
  resource_group_name = var.rg_name
  location            = var.azure_region
  sku                 = "Premium"
  admin_enabled       = true

}
