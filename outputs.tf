## Terraform outputs. These are displayed in the terminal after every "terraform apply" or "terraform output" command

output "resource_group_name" {
  value = azurerm_resource_group.default.name
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.default.name
}

# ## Sets lb_ip to our Azure ingress' IP address
output "lb_ip" {
  value = kubernetes_service.nginx.load_balancer_ingress[0].ip
}