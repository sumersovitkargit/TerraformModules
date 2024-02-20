variable "rg_name" {
  description = "resource group name"
  type        = string
}

variable "region" {
  description = "Location"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
}

variable "retention_days" {
  description = "The days for retention"
  default     = "90"
}

variable "sandbox" {
  description = "List of the workspaces names"
  type        = list(any)
}
variable "azure_region" {
  description = "Location"
  type        = string
}

variable "purpose" {
  description = "Resource is shared, bff specific?"
  type        = string
}
