variable "vnet_name" {
  description = "Name of the VNet"
  type        = string
}
 
variable "address_space" {
  description = "Address space for the VNet"
  type        = list(string)
}
 
variable "location" {
  description = "Azure region for the VNet"
  type        = string
}
 
variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}
 
variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
}
 
variable "subnet_prefixes" {
  description = "Address prefixes for the Subnet"
  type        = list(string)
}