#outputs for mysql-db-config file
output "mysql_port" {
  description = "The resource id of the MYSQL server"
  value       = "3306"
}

output "mysql_server_name" {
  description = "The name of the MYSQL server"
  value       = var.mysql_server_name
}

output "mysql_server_fqdn" {
  description = "The fully qualified domain name (FQDN) of the MYSQL server"
  value       = azurerm_mysql_server.test.fqdn
}

output "mysql_admin_login_name" {
  value       = var.mysql_admin_name
}

output "mysql_admin_password" {
  value       = var.mysql_admin_pass
}