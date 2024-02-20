output "app_service_plan_id_id" {
  #value       = azurerm_key_vault.key_vault[0].name
  value       = azurerm_app_service_plan.basicapp.id
  description = "The ID of the Key Vault."
}