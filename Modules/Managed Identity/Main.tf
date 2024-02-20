resource "azurerm_resource_group" "example" {
  name     = "rg-jp-sandbox"
  location = "Japan East"
}
resource "azurerm_user_assigned_identity" "example" {
  location            = azurerm_resource_group.example.location
  name                = "identity_sandbox"
  resource_group_name = azurerm_resource_group.example.name
}