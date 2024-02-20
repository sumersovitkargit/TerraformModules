output "kvault_name" {
  #value       = azurerm_key_vault.key_vault[0].name
  value       = azurerm_key_vault.key_vault_stage.name
  description = "The name of the Key Vault."
}

output "kvault_name_stage" {
  #value       = azurerm_key_vault.key_vault[0].name
  value       = azurerm_key_vault.key_vault_stage.name
  description = "The name of the Key Vault."
}

output "kvault_id" {
  #value       = azurerm_key_vault.key_vault[0].name
  value       = azurerm_key_vault.key_vault_stage.id
  description = "The ID of the Key Vault."
}


