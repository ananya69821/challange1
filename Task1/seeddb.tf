# resource "null_resource" "database_setup" {
#   provisioner "local-exec" {
#     command = "sqlcmd -S ${azurerm_mysql_server.sqlServer1.fully_qualified_domain_name} -U ${azurerm_mysql_server.sqlserver1.administrator_login} -P ${azurerm_mysql_server.sqlserver1.administrator_login_password} -d azurerm_mysql_database.sqlDB1.name -i 01.sql"
    
#   }
#   depends_on = [
#     azurerm_mysql_database.sqlDB1
#   ]
# }