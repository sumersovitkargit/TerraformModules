variable "workspace_name" {
  description = "Name of the Log Analytics Workspace"
  type        = string
}
 
variable "location" {
  description = "Azure region for the Log Analytics Workspace"
  type        = string
}
 
variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}
 
variable "workspace_sku" {
  description = "SKU of the Log Analytics Workspace"
  type        = string
  default     = "PerGB2018"
}