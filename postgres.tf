resource "random_password" "password" {
  length = 16
  special = true
  override_special = "_%@"
}

resource "azurerm_postgresql_server" "test" {
  name                = "bluewhiskeypostgresql"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  sku {
    name     = "B_Gen5_2"
    capacity = 2
    tier     = "Basic"
    family   = "Gen5"
  }

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = "psqladminun"
  administrator_login_password = random_password.password.result
  version                      = "9.5"
  ssl_enforcement              = "Disabled"
}

resource "azurerm_postgresql_database" "testDatabase" {
  name                = "BWDatabase"
  resource_group_name = azurerm_resource_group.default.name
  server_name         = azurerm_postgresql_server.test.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_postgresql_firewall_rule" "allow_will" {
  name                = "Will_Home"
  resource_group_name = azurerm_resource_group.default.name
  server_name         = azurerm_postgresql_server.test.name
  start_ip_address    = "107.11.55.188"
  end_ip_address      = "107.11.55.188"
}