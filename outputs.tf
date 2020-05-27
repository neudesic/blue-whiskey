## Terraform outputs. These are displayed in the terminal after every "terraform apply" or "terraform output" command

output "resource_group_name" {
  value = var.resource_group_name
}

#MYSQL OUTPUTS
output "mysql_port" {
  description = "The resource id of the MYSQL server"
  value       = "3306"
}

output "mysql_server_name" {
  description = "The name of the MYSQL server"
  value       = module.mysql-db-config.mysql_server_name
}

output "mysql_server_fqdn" {
  description = "The fully qualified domain name (FQDN) of the MYSQL server"
  value       = module.mysql-db-config.mysql_server_fqdn
}

output "mysql_admin_login_name" {
  value       = module.mysql-db-config.mysql_admin_login_name
}

output "mysql_admin_password" {
  value       = module.mysql-db-config.mysql_admin_password
}

#CLUSTER OUTPUTS
output "kubernetes_cluster_name" {
  value = module.cluster-config.kubernetes_cluster_name
}

#VAULT OUTPUTS
output "key_vault_name" {
  value = module.vault-config.key_vault_name
}

# ## Sets lb_ip to our Azure ingress' IP address
# output "lb_ip" {
#   value = kubernetes_service.nginx.load_balancer_ingress[0].ip
# }



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



/*
output "database_ids" {
  description = "The list of all database resource ids"
  value       = [azurerm_postgresql_database.testDatabase.*.id]
}

output "firewall_rule_ids" {
  description = "The list of all firewall rule resource ids"
  value       = [azurerm_postgresql_firewall_rule.allow_will.*.id]
}
*/

