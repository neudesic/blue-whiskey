resource "azurerm_mysql_server" "test" {
  name                = var.mysql_server_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = "B_Gen5_2"

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = var.mysql_admin_name
  administrator_login_password = var.mysql_admin_pass
  version                      = "8.0"
  ssl_enforcement              = "Disabled"
}

resource "azurerm_mysql_firewall_rule" "allow_will" {
  name                = "Will_Home"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.test.name
  start_ip_address    = "107.11.55.188"
  end_ip_address      = "107.11.55.188"
}
resource "azurerm_mysql_firewall_rule" "allow_chris_home" {
  name                = "allow_chris_home_ip"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.test.name
  start_ip_address    = "24.131.166.180"
  end_ip_address      = "24.131.166.180"
}