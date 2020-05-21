## Terraform outputs. These are displayed in the terminal after every "terraform apply" or "terraform output" command

output "resource_group_name" {
  value = azurerm_resource_group.default.name
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.default.name
}


# ## Sets lb_ip to our Azure ingress' IP address
# output "lb_ip" {
#   value = kubernetes_service.nginx.load_balancer_ingress[0].ip
# }

output "server_name" {
  description = "The name of the PostgreSQL server"
  value       = azurerm_postgresql_server.test.name
}

output "server_fqdn" {
  description = "The fully qualified domain name (FQDN) of the PostgreSQL server"
  value       = azurerm_postgresql_server.test.fqdn
}

# output "administrator_login" {
#   value = "${var.administrator_login}"
# }

# output "administrator_password" {
#   value     = "${var.administrator_password}"
#   sensitive = true
# }

# output "server_id" {
#   description = "The resource id of the PostgreSQL server"
#   value       = azurerm_postgresql_server.test.id
# }

output "port" {
  description = "The resource id of the PostgreSQL server"
  value       = "5432"
}

output "database_ids" {
  description = "The list of all database resource ids"
  value       = [azurerm_postgresql_database.testDatabase.*.id]
}

output "firewall_rule_ids" {
  description = "The list of all firewall rule resource ids"
  value       = [azurerm_postgresql_firewall_rule.allow_will.*.id]
}

output "your_server_password" {
  value       = random_password.password.result
}