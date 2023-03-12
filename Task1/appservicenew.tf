
resource "azurerm_windows_web_app" "windows_web_app1" {
  name                = "${var.env}-asintpcs-apiswgpcs-tf"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  service_plan_id     = azurerm_app_service_plan.aspwinint01.id
  
  site_config {
    application_stack {
      current_stack = "dotnet"
      dotnet_version = "v6.0"
    }
  }
  identity {
    type = "SystemAssigned"
  }
  depends_on = [
    azurerm_app_service_plan.aspwinint01
  ]
}

resource "azurerm_windows_web_app" "windows_web_app2" {
  name                = "${var.env}-front-end-tf"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  service_plan_id     = azurerm_app_service_plan.aspwinint01.id
  site_config {
    application_stack {
      current_stack = "node"
      node_version = "16-LTS"
    }
  }
  identity {
    type = "SystemAssigned"
  }
  depends_on = [
    azurerm_app_service_plan.aspwinint01
  ]
}

resource "azurerm_app_service_virtual_network_swift_connection" "virtual_network_swift_connection" {
  app_service_id = azurerm_windows_web_app.windows_web_app1.id
  subnet_id      = azurerm_subnet.subnet.id
  depends_on = [
    azurerm_windows_web_app.windows_web_app1
  ]
}

