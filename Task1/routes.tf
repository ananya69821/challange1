resource "azurerm_route_table" "route_table" {
  name                = "${var.env}-route-table"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  route {
    name                   = "${var.env}-route"
    address_prefix         = "10.100.0.0/14"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.1.1"
  }
}

resource "azurerm_subnet_route_table_association" "routeTable-sun" {
  subnet_id      = azurerm_subnet.subnet.id
  route_table_id = azurerm_route_table.route_table.id
  depends_on = [
    azurerm_route_table.route_table,
    azurerm_subnet.subnet
  ]
}