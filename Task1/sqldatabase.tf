resource "azurerm_mssql_server" "sqlServer1" {
  name                = "${var.env}-sqlserver1"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  version                      = "12.0"
  public_network_access_enabled = false

  administrator_login          = "${azurerm_key_vault_secret.username.value}"
  administrator_login_password = "${azurerm_key_vault_secret.pwd.value}"

  tags = local.common_tags
  identity {
    type = "SystemAssigned"
  }
  depends_on = [
    azurerm_key_vault.keyvault
  ]
}


resource "azurerm_mssql_database" "sqlDB1" {
  name                = "${var.env}-sqlDB1"
  server_id      = azurerm_mssql_server.sqlServer1.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 1
  read_scale     = false
  sku_name       = "S0"
  zone_redundant = false
  
  depends_on = [
    azurerm_mssql_server.sqlServer1
  ]

}

# resource "azurerm_mssql_firewall_rule" "alloServices" {
#   name             = "AllowAzureServices"
#   server_id        = azurerm_mssql_server.sqlServer1.id
#   start_ip_address = "0.0.0.0"
#   end_ip_address   = "0.0.0.0"
# }