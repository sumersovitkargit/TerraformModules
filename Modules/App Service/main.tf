
resource "azurerm_app_service_plan" "basicapp" {
  name                = var.service_Plan_stage_name
  location            = var.azure_region
  resource_group_name = var.rg_name
  kind                = "Windows"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "basic_app" {
  name                = "basic_app"
  location            = var.azure_region
  resource_group_name = var.rg_name
  app_service_plan_id = azurerm_app_service_plan.basicapp.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }

  key_vault_reference_identity_id = var.key_vault_reference_identity_id
}

resource "azurerm_app_service_slot" "staging" {
  name                = "staging"
  location            = var.azure_region
  resource_group_name = var.rg_name
  app_service_name    = azurerm_app_service.basic_app.name
  app_service_plan_id = azurerm_app_service_plan.basicapp.id

  app_settings = {
    "SLOT_NAME" = "staging"
  }
}

resource "azurerm_app_service_slot" "production" {
  name                = "production"
  location            = var.azure_region
  resource_group_name = var.rg_name
  app_service_name    = azurerm_app_service.basic_app.name
  app_service_plan_id = azurerm_app_service_plan.basicapp.id

  app_settings = {
    "SLOT_NAME" = "production"
  }
}