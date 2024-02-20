output "workspace_id" {
  value = azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id
  description = "Specifies the workspace id of the log analytics workspace"
}

output "resource_id" {
  value = azurerm_log_analytics_workspace.log_analytics_workspace.id
  description = "Specifies the resource id of the log analytics workspace"
}

output "workspace_name" {
  value = azurerm_log_analytics_workspace.log_analytics_workspace.name
  description = "Log analytics workspace name"
}