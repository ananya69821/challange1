
resource "azurerm_network_security_group" "network_security_group1" {
  name                = "${var.env}-nsg1"
  location            = "canada central"
  resource_group_name = azurerm_resource_group.this.name

  security_rule {
    name                       = "AllowHttps"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allowhttp"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  depends_on = [
    azurerm_subnet.subnet,
    azurerm_subnet.subnet1
  ]
}

resource "azurerm_network_security_group" "network_security_group" {
  name                = "${var.env}-nsg"
  location            = "canada central"
  resource_group_name = azurerm_resource_group.this.name

  security_rule {
    name                       = "Allow1433"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allowhttps"
    priority                   = 101
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  depends_on = [
    azurerm_subnet.subnet,
    azurerm_subnet.subnet1
  ]
}

resource "azurerm_network_security_group" "network_security_group2" {
  name                = "${var.env}-nsg2"
  location            = "canada central"
  resource_group_name = azurerm_resource_group.this.name

  security_rule {
    name                       = "AllowRdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allowAccess"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  depends_on = [
    azurerm_subnet.sql_subnet
  ]
}

resource "azurerm_subnet_network_security_group_association" "nsg-association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.network_security_group.id
}


resource "azurerm_subnet_network_security_group_association" "nsg-association1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.network_security_group1.id
}

resource "azurerm_subnet_network_security_group_association" "nsg-association2" {
  subnet_id                 = azurerm_subnet.sql_subnet.id
  network_security_group_id = azurerm_network_security_group.network_security_group2.id
}