#outputs for db-config file
output "postgresql_port" {
  description = "The resource id of the PostgreSQL server"
  value       = "5432"
}

output "postgresql_server_name" {
  description = "The name of the PostgreSQL server"
  value       = var.server_name
}

output "postgresql_server_fqdn" {
  description = "The fully qualified domain name (FQDN) of the PostgreSQL server"
  value       = azurerm_postgresql_server.test.fqdn
}

output "postgresql_admin_login_name" {
  value = var.postgresql_admin_name
}

output "postgresql_admin_password" {
  value = var.postgresql_admin_pass
}