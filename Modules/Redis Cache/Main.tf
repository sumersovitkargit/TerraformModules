[6:21 PM] Modhupalli Srilekha
Redis:
 
resource "azurerm_subnet" "Subnet" {
  name                 = "snet-jp-sandbox"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.14.16.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
}
 
resource "azurerm_private_dns_zone" "private_dns_zone_rediscache" {
  name                = "jekplatstg-kvsdredisprivatednszone.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}
 
resource "azurerm_private_dns_zone_virtual_network_link" "virtual_network_link_rediscache" {
  name                  = "jekplatstg-kvsdredisprivatednszonevirnetlink.com"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_rediscache.name
  virtual_network_id    = azurerm_virtual_network.Vnet.id
  resource_group_name   = azurerm_resource_group.rg.name
}
 
resource "azurerm_redis_cache" "Redis" {
  name                = "redis-jp-sandbox"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  capacity            = 0
  family              = "C"
  sku_name            = "Basic"
  enable_non_ssl_port = true
  minimum_tls_version = "1.2"
 
  redis_configuration {
  }
}
 
resource "azurerm_private_endpoint" "PrivateEndpoint" {
  name                = "pep-jp-sandbox"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.snet.id
  private_dns_zone_group {
    name                 = "jekplatstg-KVSDprivatednsrediszonegroup"
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zone_rediscache.id]
  }
 
  private_service_connection {
    name                           = "jekplatstg-KVSDPriSerConnRedis"
    private_connection_resource_id = azurerm_redis_cache.arc.id
    is_manual_connection           = false
    subresource_names              = ["redisCache"]
  }
}