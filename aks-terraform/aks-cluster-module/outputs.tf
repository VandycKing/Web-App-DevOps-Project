
output "aks_cluster_name" {
  description = "Specifies the name output of the aks cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster_rs.name
}

output "aks_cluster_id" {
  description = "Specifies the id of the aks cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster_rs.id
}

output "aks_kubeconfig" {
  description = "Specifies the kubernetes configuration file of the cluster"
  value       = azurerm_kubernetes_cluster.aks_cluster_rs.kube_config_raw
}
