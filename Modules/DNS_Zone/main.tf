

resource "null_resource" "import_dns_zone" {
  provisioner "local-exec" {
    command = "terraform import azurerm_dns_zone.example /subscriptions/94e12df9-8810-4706-a83d-06770afb5589/resourceGroups/dns-zones/providers/Microsoft.Network/dnsZones/solunistresearch.net"
  }

  #depends_on = [azurerm_resource_group.example]
}

resource "azurerm_dns_zone" "solunistresearch" {
  name                = "solunistresearch.net"  # Replace with your actual DNS zone name
  resource_group_name = var.rg_name
  // Add any other configuration options as needed
}
