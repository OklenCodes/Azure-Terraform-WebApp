data "azurerm_client_config" "current" {}  #Use to access the configuration of the AzureRM provider



resource "azurerm_key_vault" "ok-keyvault" {
  name                        = "okkeyvaulttest"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name                    = "standard"

}

# this permission is for service connection from app registration, this is given to store database secrets to key vault
resource "azurerm_key_vault_access_policy" "kv_access_policy_sc" {

  key_vault_id = azurerm_key_vault.ok-keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = "54b84d5e-84a5-49fc-8c76-f8d0604cc8c1"
  key_permissions = [
    "Get", "List"
  ]
  secret_permissions = [
    "Get", "Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set"
  ]

  depends_on = [azurerm_key_vault.ok-keyvault]
}

# permission to my self
resource "azurerm_key_vault_access_policy" "kv_access_policy_me" {
  key_vault_id       = azurerm_key_vault.ok-keyvault.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = "ab35c899-90de-4dcc-9d4f-ebae7a569976"
  key_permissions    = ["Get", "List"]
  secret_permissions = ["Get", "Backup", "Delete", "List", "Purge", "Recover", "Restore", "Set"]

  depends_on = [azurerm_key_vault.ok-keyvault]
}


# Retrieve the managed identity's principal ID (object_id)
resource "azurerm_key_vault_access_policy" "kv_access_policy_web_app" {
  key_vault_id  = azurerm_key_vault.ok-keyvault.id
  tenant_id     = "31673592-0635-48d1-a494-9887ca994b24"
  object_id     = azurerm_linux_web_app.frontend-webapp.identity[0].principal_id

  key_permissions    = ["Get", "List", "Update", "Delete"]
  secret_permissions = ["Get", "List", "Set", "Delete"]

  depends_on = [azurerm_linux_web_app.frontend-webapp]
}


# need to enable the logging for key vault
# here i used the same storge accout created for function app: azurerm_linux_function_app

resource "azurerm_monitor_diagnostic_setting" "kvlog" {
  name                       = "kv-log-diagonise"
  target_resource_id         = azurerm_key_vault.ok-keyvault.id
  storage_account_id         = azurerm_storage_account.fn-storageaccount.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.ok-loganalytics.id


  enabled_log {
    category = "AuditEvent"


  }

  metric {
    category = "AllMetrics"
    enabled  = true

  }
  depends_on = [
    azurerm_storage_account.fn-storageaccount
  ]
}
