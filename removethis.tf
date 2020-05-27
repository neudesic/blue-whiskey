#A NON MODULAR CONFIG FILE CREATING A MYSQL SERVER

# #generates random name and ID for mysql-db
# resource "random_pet" "primary-mysql" {
# }
# resource "random_id" "primary-mysql" {
#   byte_length = 10
# }
# #generate db server admin password for mysql
# resource "random_password" "password-mysql" {
#   length = 16
#   special = true
#   override_special = "_%@"
# }

# resource "azurerm_mysql_server" "test" {
#   name                = "${random_pet.primary-mysql.id}-${random_id.primary-mysql.dec}"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   sku_name = "B_Gen5_2"
#   storage_profile {
#     storage_mb            = 5120
#     backup_retention_days = 7
#     geo_redundant_backup  = "Disabled"
#   }
#   administrator_login          = "lnadmin-mysql"
#   administrator_login_password = random_password.password-mysql.result
#   version                      = "8.0"
#   ssl_enforcement              = "Disabled"
# }

# resource "azurerm_mysql_firewall_rule" "allow_will" {
#   name                = "Will_Home"
#   resource_group_name = var.resource_group_name
#   server_name         = azurerm_mysql_server.test.name
#   start_ip_address    = "107.11.55.188"
#   end_ip_address      = "107.11.55.188"
# }
# resource "azurerm_mysql_firewall_rule" "allow_chris_home" {
#   name                = "allow_chris_home_ip"
#   resource_group_name = var.resource_group_name
#   server_name         = azurerm_mysql_server.test.name
#   start_ip_address    = "24.131.166.180"
#   end_ip_address      = "24.131.166.180"
# }


# #OUTPUTS
# output "mysql_port" {
#   description = "The resource id of the MYSQL server"
#   value       = "3306"
# }

# output "mysql_server_name" {
#   description = "The name of the MYSQL server"
#   value       = azurerm_mysql_server.test.name
# }

# output "mysql_server_fqdn" {
#   description = "The fully qualified domain name (FQDN) of the MYSQL server"
#   value       = azurerm_mysql_server.test.fqdn
# }

# output "mysql_admin_login_name" {
#   value       = azurerm_mysql_server.administrator_login
# }

# output "mysql_admin_password" {
#   value       = random_password.password-mysql.result
# }