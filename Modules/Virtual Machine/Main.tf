resource "azurerm_virtual_network" "Vnet" {
  name                = "vnet-jp-sandbox"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  address_space       = ["10.0.0.0/16"]  
  depends_on = [
    azurerm_resource_group.RG
  ]
}
 
resource "azurerm_subnet" "SubnetA" {
  name                 = "snet-jp-sandbox"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on = [
    azurerm_virtual_network.Vnet
  ]
}
resource "azurerm_subnet" "Azure_Bastion_Subnet" {
  name                 = "bas-jp-sandbox"
  resource_group_name  = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes     = ["10.0.2.0/24"]
  depends_on = [
    azurerm_virtual_network.Vnet
  ]
}
 
resource "azurerm_network_interface" "nic" {
  name                = "NIC"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
 
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.SubnetA.id
    private_ip_address_allocation = "Dynamic"
  }
 
  depends_on = [
    azurerm_virtual_network.Vnet,
    azurerm_subnet.SubnetA
  ]
}
 
resource "azurerm_windows_virtual_machine" "VM" {
  name                = "vm-jp-snadbox"
  resource_group_name = azurerm_resource_group.RG.name
  location            = azurerm_resource_group.RG.location
  size                = "Standard_D2s_v3"
  admin_username      = "sandboxuser"
  admin_password      = "Azure@123"  
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
 
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
 
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
 
  depends_on = [
    azurerm_network_interface.nic
  ]
}
 
 
 
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-jp-sandbox"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
 
 
  security_rule {
    name                       = "Allow_HTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
 
resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.SubnetA.id
  network_security_group_id = azurerm_network_security_group.nsg.id
  depends_on = [
    azurerm_network_security_group.nsg
  ]
}
 
resource "azurerm_public_ip" "bastion_ip" {
  name                = "bastion-ip"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
 
resource "azurerm_bastion_host" "app_bastion" {
  name                = "app-bastion"
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
 
  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.Azure_Bastion_Subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_ip.id
  }
 
  depends_on=[
    azurerm_subnet.Azure_Bastion_Subnet,
    azurerm_public_ip.bastion_ip
  ]
}