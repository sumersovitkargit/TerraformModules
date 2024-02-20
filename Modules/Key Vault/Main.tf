resource "azurerm_key_vault" "key_vault" {
  count                       = length(var.sandbox)
  name                        = "kv-${var.sandbox[count.index]}-${var.purpose}"
  location                    = var.azure_region
  resource_group_name         = var.rg_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true
  soft_delete_retention_days  = var.retention_days
  enabled_for_disk_encryption = true

}

resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  count               = length(var.sandbox)
  location            = var.azure_region
  name                = "uai-${var.sandbox[count.index]}-${var.purpose}"
  resource_group_name = var.rg_name
}

resource "azurerm_key_vault_access_policy" "key_vault_access_policy" {
  count        = length(var.sandbox)
  key_vault_id = azurerm_key_vault.key_vault[count.index].id
  tenant_id    = var.tenant_id
  object_id    = azurerm_user_assigned_identity.user_assigned_identity[count.index].principal_id

  key_permissions = [
    "Get",
    "List",
    "Update",
    "Create",
    "Import",
    "Delete",
    "Recover",
    "Backup",
    "Restore",
    "Decrypt",
    "Encrypt",
    "UnwrapKey",
    "WrapKey",
    "Verify",
    "Sign"
  ]

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Backup",
    "Restore"
  ]
}