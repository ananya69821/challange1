resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.env}-vnet01"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [var.virtual_network_addrs.web-vnet]
  #dns_servers         = ["10.1.0.4", "10.1.0.5"]
}

resource "azurerm_virtual_network" "sql_virtual_network" {
  name                = "${var.env}-vnet02"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = [var.virtual_network_addrs.db-vnet]
  #dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

