variable "rg_name" {
  description = "resource group name"
  type        = string
}

variable "env" {
  type = string
}

variable "region" {
  description = "Location"
  type        = string
}

variable "azure_region" {
  description = "Location"
  type        = string
}

variable "aks_subnet" {
  description = "subnet to deploy AKS"
  type        = string
}

variable "min_node" {
  description = "Minimum nodes"
}

variable "max_node" {
  description = "Maximum number of nodes"
}

variable "vm_family" {
  description = "VM size"
}

variable "dns_name" {
  description = "common name"
}

variable "admin_group_id" {
  description = "AKS cluster Group object ID"
  type        = list(any)
}

variable "purpose" {
  description = "Resource is shared, bff specific?"
  type        = string
}

variable "usernode_pool" {
  description = "list of the usernode pool"
  type        = list(any)
  default     = ["userpool1", "userpool2"]
}

variable "userpool_details" {
  type = list(object({
    name              = string
    node_taint        = list(string)
    node_label        = list(string)
    userpool_min_node = any
    userpool_max_node = any
    vm_family         = string
  }))

}

variable "log_analytics_id" {
  description = "ID of the log analytics"
  type = string
}

variable "common_tags" {
  description = "List of common tags"
}

variable "default_node_count" {
  description = "Count of default node"
}

variable "min_default_node_count" {
  description = "Min node count for default pool"
}

variable "max_default_node_count" {
  description = "Min node count for default pool"
}

variable "default_node_family" {
  description = "VM family for default node"
}
