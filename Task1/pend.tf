
resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "${azurerm_windows_web_app.windows_web_app1.name}-pend"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = azurerm_subnet.subnet1.id

  private_service_connection {
    name                           = "${azurerm_windows_web_app.windows_web_app1.name}-pend-sc01"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_windows_web_app.windows_web_app1.id
    subresource_names              = ["sites"]
  }
  depends_on = [
    azurerm_subnet.subnet1,
    azurerm_windows_web_app.windows_web_app1
  ]
}

resource "azurerm_private_endpoint" "private_endpoint1" {
  name                = "${azurerm_key_vault.keyvault.name}-pend"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = azurerm_subnet.subnet1.id

  private_service_connection {
    name                           = "${azurerm_key_vault.keyvault.name}-pend-sc01"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_key_vault.keyvault.id
    subresource_names              = ["vault"]
  }
  depends_on = [
    azurerm_key_vault.keyvault
  ]
}

resource "azurerm_private_endpoint" "sql_private_endpoint" {
  name                    = "${azurerm_mssql_server.sqlServer1.name}-pend"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  subnet_id               = azurerm_subnet.sql_subnet.id

  private_service_connection {
    name                           = "${azurerm_mssql_server.sqlServer1.name}-pend-sc01"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_mssql_server.sqlServer1.id
    subresource_names              = ["sqlServer"]
  }
  depends_on = [
    azurerm_mssql_server.sqlServer1,
    azurerm_subnet.sql_subnet
  ]
}