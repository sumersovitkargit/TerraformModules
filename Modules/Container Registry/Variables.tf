variable "rg_name" {
  description = "resource group name"
  type        = string
}

variable "region" {
  description = "Location"
  type        = string
}

variable "azure_region" {
  description = "Azure specific region"
  type        = string
}

variable "env" {
  description = "environment name"
  type        = string
}

variable "purpose" {
  description = "purpose of the resource"
  type        = string
}
