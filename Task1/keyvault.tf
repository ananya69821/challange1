
resource "azurerm_key_vault" "keyvault" {
  name                        = "${var.env}-kv001"
  location                    = azurerm_resource_group.this.location
  resource_group_name         = azurerm_resource_group.this.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 90
  purge_protection_enabled    = false
  #public_network_access_enabled = true  

  sku_name = "standard"

  access_policy = [{
    application_id          = null
    certificate_permissions = ["Get", "List","Import"]
    key_permissions         = ["Get", "List"]
    object_id               = "3d4cf188-845a-4044-98e9-421bb3a67b47"
    secret_permissions      = ["Get", "List", "Set"]
    storage_permissions     = ["Get", "List"]
    tenant_id               = data.azurerm_client_config.current.tenant_id
    },
    {
      application_id          = null
      certificate_permissions = ["Get", "List","Import"]
      key_permissions         = ["Get", "List"]
      object_id               = data.azurerm_client_config.current.object_id
      secret_permissions      = ["Get", "List", "Set"]
      storage_permissions     = ["Get", "List"]
      tenant_id               = data.azurerm_client_config.current.tenant_id
    },
    {
      application_id          = null
      certificate_permissions = ["Get", "List","Import"]
      key_permissions         = ["Get", "List"]
      object_id               = "12ea1bbc-d19b-4dd8-b843-c995b7cd2321"
      secret_permissions      = ["Get", "List", "Set"]
      storage_permissions     = ["Get", "List"]
      tenant_id               = data.azurerm_client_config.current.tenant_id
    },
    {
      application_id          = null
      certificate_permissions = ["Get", "List","Import"]
      key_permissions         = ["Get", "List"]
      object_id               = "08bd6b32-dd80-4d2f-b979-3fa65d3d3a1e"
      secret_permissions      = ["Get", "List", "Set"]
      storage_permissions     = ["Get", "List"]
      tenant_id               = data.azurerm_client_config.current.tenant_id
    },
     {
      application_id          = null
      certificate_permissions = ["Get", "List","Import"]
      key_permissions         = ["Get", "List"]
      object_id               = azurerm_windows_web_app.windows_web_app1.identity[0].principal_id
      secret_permissions      = ["Get", "List", "Set"]
      storage_permissions     = ["Get", "List"]
      tenant_id               = data.azurerm_client_config.current.tenant_id
    },
    {
      application_id          = null
      certificate_permissions = ["Get", "List","Import"]
      key_permissions         = ["Get", "List"]
      object_id               = azurerm_windows_web_app.windows_web_app2.identity[0].principal_id
      secret_permissions      = ["Get", "List", "Set"]
      storage_permissions     = ["Get", "List"]
      tenant_id               = data.azurerm_client_config.current.tenant_id
    }
  ]


  network_acls {
    bypass         = "AzureServices"
    default_action = "Allow"
    ip_rules       = ["13.126.73.102/32"]
  }
  depends_on = [
    azurerm_windows_web_app.windows_web_app1,
    azurerm_windows_web_app.windows_web_app2
  ]
}

resource "azurerm_key_vault_secret" "username" {
  name         = "username"
  value        = "test"
  key_vault_id = azurerm_key_vault.keyvault.id
}
resource "azurerm_key_vault_secret" "pwd" {
  name         = "pwd"
  value        = "thisIsKat11!"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# resource "azurerm_key_vault_certificate" "cert1" {
#   name         = "wild-sunwingapipriv-com"
#   key_vault_id = azurerm_key_vault.keyvault.id

#   certificate {
#     contents = filebase64("certificates/wild-sunwingapipriv-com.pfx")
#     password = ""
#   }
# }
