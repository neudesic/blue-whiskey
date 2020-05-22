resource "random_pet" "primary" {
  
}

resource "random_id" "primary" {
  byte_length = 10
}

resource "random_password" "password" {
  length = 16
  special = true
  override_special = "_%@"
}

resource "azurerm_postgresql_server" "test" {
  name                = "${random_pet.primary.id}-${random_id.primary.dec}"
  location            = var.location
  resource_group_name = var.resource_group_name

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

  administrator_login          = var.postgresql_admin_name
  administrator_login_password = random_password.password.result
  version                      = "9.5"
  ssl_enforcement              = "Disabled"

  depends_on = [azurerm_resource_group.default]
}

resource "azurerm_postgresql_database" "testDatabase" {
  name                = "BWDatabase"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.test.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

resource "azurerm_postgresql_firewall_rule" "allow_will" {
  name                = "Will_Home"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.test.name
  start_ip_address    = "107.11.55.188"
  end_ip_address      = "107.11.55.188"
}

resource "azurerm_postgresql_firewall_rule" "allow_chris_home" {
  name                = "allow_chris_home_ip"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.test.name
  start_ip_address    = "24.131.166.180"
  end_ip_address      = "24.131.166.180"
}