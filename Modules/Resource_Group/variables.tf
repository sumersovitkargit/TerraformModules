variable "region" {
    description = "Location of resources"
    type = string
}

variable "azure_region" {
    description = "Azure location"
    type = string
}

variable "rg_name" {
    description = "Resource group name"
}


variable "env" {
  description = "Environment name"
}

variable "purpose" {
  description = "Kamereon resource?"
  type        = string
}

variable "tags" {
  description = "List of common tags"
}