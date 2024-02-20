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

variable "kv_infra_name" {
  description = "Infra Key Vault name"
}

variable "kv_stage_name" {
  description = "Stage Key Vault name"
}

variable "tenant_id" {
    description = "Tenant ID"
    type = string
}

variable "infra_retention_days" {
    description = "Retention days"
}

variable "uai_name_infra" {
    description = "Name of User Assigned Identity for Infra"
}

variable "uai_name_stage" {
    description = "Name of User Assigned Identity for stage"
}

variable "key_vault_access_policies" {
  description = "List of Key Vault access policies"
  type        = list(object({
    tenant_id   = string
    object_id   = string
    permissions = map(list(string))
  }))
}

variable "aks_cmk_name" {
    description = "Retention days"
}

variable "st_cmk_name" {
    description = "Retention days"
}

variable "psql_cmk_name" {
    description = "Retention days"
}

variable "kv_infra_diag_name" {
    description = "Infra Key Vault Diagnostics Settings name"
}

variable "kv_stage_diag_name" {
    description = "Stage Key Vault Diagnostics Settings name"
}

# variable "sandbox_envs" {
#   description = "List of the workspaces names"
#   type        = list(any)
# }

variable "kv_sku" {
    description = "Azure location"
    type = string
}

variable "log_analytics_workspace_id" {
  description = "Specifies the log analytics workspace id"
  type        = string
}

variable "kv_purpose_list" {
  description = "Key vault purpose"
  type        = list(string)
 }

 variable "disk_encryption_set_name" {
    description = "Disk Encryption Set name"
    type = string
}