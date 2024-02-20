data "azurerm_client_config" "current" {}

# data "azuread_service_principal" "spn" {  
#     display_name = "spn-jp-sandbox-test"
# }




###########################
# Key Vault for Application
###########################

resource "azurerm_key_vault" "key_vault_stage" {

  name                        = var.kv_stage_name #"kv-${var.region}-${var.env}-${var.kv_purpose_list[0]}-${var.purpose}-tm"
  location                    = var.azure_region
  resource_group_name         = var.rg_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 15
  purge_protection_enabled    = false
  sku_name                    = var.kv_sku
  tags                        = var.tags
}

resource "azurerm_user_assigned_identity" "user_assigned_identity_stage" {

  location              = var.azure_region
  name                  = var.uai_name_stage #"id-${var.region}-${var.env}-${var.kv_purpose_list[0]}-${var.purpose}-tm"
  resource_group_name   = var.rg_name
}

# Create Key Vault access policies
resource "azurerm_key_vault_access_policy" "key_vault_access_policies_stage" {
  count         = length(var.key_vault_access_policies)
  key_vault_id  = azurerm_key_vault.key_vault_stage.id
 
  tenant_id     = var.key_vault_access_policies[count.index].tenant_id
  object_id     = var.key_vault_access_policies[count.index].object_id
 
  secret_permissions       = var.key_vault_access_policies[count.index].permissions.secrets #["secrets"]
  key_permissions          = var.key_vault_access_policies[count.index].permissions.keys #["keys"]
  #storage_permissions      = var.key_vault_access_policies[count.index].permissions.storage #["storage"]
}
