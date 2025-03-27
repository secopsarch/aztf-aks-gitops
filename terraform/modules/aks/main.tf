terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                = "default"
    node_count          = var.node_count
    vm_size             = var.vm_size
    min_count           = var.min_count
    max_count           = var.max_count
    enable_auto_scaling = true
    vnet_subnet_id      = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    load_balancer_sku  = "standard"
    network_policy     = "azure"
  }

  role_based_access_control {
    enabled = true
    azure_active_directory {
      managed = true
    }
  }

  tags = var.tags
}

# Output the cluster's credentials and other important information
output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "cluster_endpoint" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.host
}

output "cluster_ca_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate
  sensitive = true
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "resource_group_name" {
  value = azurerm_kubernetes_cluster.aks.resource_group_name
}

output "node_resource_group" {
  value = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "system_assigned_identity" {
  value = azurerm_kubernetes_cluster.aks.identity[0].principal_id
} 