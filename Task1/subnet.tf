resource "azurerm_subnet" "subnet" {
  name                                           = "${var.env}-${azurerm_virtual_network.virtual_network.name}-sub01"
  resource_group_name                            = azurerm_resource_group.this.name
  virtual_network_name                           = azurerm_virtual_network.virtual_network.name
  address_prefixes                               = [var.subnet_names.web-subnet-out]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
  delegation {
    name = "subnet-delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

# resource "azurerm_subnet" "subnet1" {
#   for_each = var.subnet_names
#   name                                           = "${var.env}-${each.key}"
#   resource_group_name                            = azurerm_resource_group.this.name
#   virtual_network_name                           = azurerm_virtual_network.virtual_network.name
#   address_prefixes                               = [each.value]
#   enforce_private_link_endpoint_network_policies = true
#   enforce_private_link_service_network_policies  = true
#  }

resource "azurerm_subnet" "subnet1" {
  name                                           = "${var.env}-${azurerm_virtual_network.virtual_network.name}-sub02"
  resource_group_name                            = azurerm_resource_group.this.name
  virtual_network_name                           = azurerm_virtual_network.virtual_network.name
  address_prefixes                               = [var.subnet_names.web-subnet-in]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
 }

 resource "azurerm_subnet" "sql_subnet" {
  name                    = "${var.env}-${azurerm_virtual_network.sql_virtual_network.name}-sub01"
  resource_group_name     = azurerm_resource_group.this.name
  virtual_network_name    = azurerm_virtual_network.sql_virtual_network.name
  address_prefixes        = [var.subnet_names.sql-subnet-in]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}