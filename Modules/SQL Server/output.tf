output "SQLServer_id" {
  #value       = azurerm_key_vault.key_vault[0].name
  value       = azurerm_sql_server.example.id
  description = "The ID of the Key Vault."
}