output "kube_config" {
  description = "Raw kube config for the cluster"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "cluster_endpoint" {
  description = "The cluster endpoint"
  value       = azurerm_kubernetes_cluster.aks.kube_config.0.host
}

output "cluster_ca_certificate" {
  description = "The cluster CA certificate"
  value       = azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate
  sensitive   = true
}

output "cluster_name" {
  description = "The name of the cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_kubernetes_cluster.aks.resource_group_name
}

output "node_resource_group" {
  description = "The name of the node resource group"
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "system_assigned_identity" {
  description = "The system assigned identity principal ID"
  value       = azurerm_kubernetes_cluster.aks.identity[0].principal_id
} 