resource "azurerm_app_service_plan" "aspwinint01" {
  name                = "${var.env}-aspwinint01"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  kind                = "App"

  sku {
    tier     = var.sku_tier[var.env]
    size     = var.sku_size[var.env]
    capacity = var.sku_capacity[var.env]
  }

  tags = local.common_tags
  depends_on = [
    azurerm_resource_group.this
  ]
}

