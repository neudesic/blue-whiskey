#outputs for cluster-config module

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.default.name
}