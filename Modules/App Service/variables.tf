variable "region" {
    description = "Location of resources"
    type = string
}

variable "azure_region" {
    description = "Azure location"
    type = string
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

variable "rg_name" {
    description = "Resource group name"
    type = string
}

variable "service_Plan_stage_name" {
  description = "Stage Key Vault name"
}

variable "key_vault_reference_identity_id" {
  description = "Stage Key Vault name"
}