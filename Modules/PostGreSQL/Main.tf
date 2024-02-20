resource "azurerm_network_security_group" "nsg_sandbox" {
  for_each = 
  name                = "jekplatstg-sandbox-netsecgroup"
  location            = var.azure_region
  resource_group_name = var.rg_name

  security_rule {
    name                       = "jekplatstg-sandbox-netsecgrouprule"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "asnsga_sandbox" {
  subnet_id                 = azurerm_subnet.postgressn.id
  network_security_group_id = azurerm_network_security_group.nsg_sandbox.id
}

resource "azurerm_private_dns_zone" "apdnz_sandbox" {
  name                = "postgres-sandbox-pridnszone.private.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
  depends_on = [azurerm_subnet_network_security_group_association.asnsga_sandbox]
}


resource "azurerm_private_dns_zone_virtual_network_link" "apdnzvnl_sandbox" {
  name                  = "sandbox-pridnszone-virnetLink.com"
  private_dns_zone_name = azurerm_private_dns_zone.apdnz_sandbox.name
  virtual_network_id    = azurerm_virtual_network.avn.id
  resource_group_name   = azurerm_resource_group.rg.name
}

resource "azurerm_postgresql_flexible_server" "apost_sandbox" {
  name                   = "pgdb-kplat-jp-lowerenv-sandbox-001"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  version                = "13"
  delegated_subnet_id    = azurerm_subnet.postgressn.id
  private_dns_zone_id    = azurerm_private_dns_zone.apdnz_sandbox.id
  administrator_login    = "adminuser"
  administrator_password = "Password@1234"
  zone                   = "1"
  storage_mb             = 65536
  sku_name               = "GP_Standard_D2s_v3"
  backup_retention_days  = 7
  depends_on = [azurerm_private_dns_zone_virtual_network_link.apdnzvnl_sandbox]

  authentication {
    active_directory_auth_enabled = "false"
    password_auth_enabled         = "true"
  }

}