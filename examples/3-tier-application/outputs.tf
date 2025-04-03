output "resource_group_name" {
  description = "The name of the resource group"
  value       = module.network.resource_group_name
}

output "vnet_id" {
  description = "The ID of the virtual network"
  value       = module.network.vnet_id
}

output "web_subnet_id" {
  description = "The ID of the web subnet"
  value       = module.network.web_subnet_id
}

output "app_subnet_id" {
  description = "The ID of the app subnet"
  value       = module.network.app_subnet_id
}

output "db_subnet_id" {
  description = "The ID of the database subnet"
  value       = module.network.db_subnet_id
}

output "dns_zone_id" {
  description = "The ID of the private DNS zone"
  value       = module.privatedns.dns_zone_id
}

output "dns_zone_name" {
  description = "The name of the private DNS zone"
  value       = module.privatedns.dns_zone_name
}

output "acr_id" {
  description = "The ID of the Azure Container Registry"
  value       = module.acr.acr_id
}

output "acr_login_server" {
  description = "The login server URL of the Azure Container Registry"
  value       = module.acr.acr_login_server
}

output "acr_username" {
  description = "The username for the Azure Container Registry"
  value       = module.acr.acr_username
}

output "mysql_server_id" {
  description = "The ID of the MySQL Flexible Server"
  value       = module.mysql.mysql_server_id
}

output "mysql_server_name" {
  description = "The name of the MySQL Flexible Server"
  value       = module.mysql.mysql_server_name
}

output "mysql_server_fqdn" {
  description = "The fully qualified domain name of the MySQL Flexible Server"
  value       = module.mysql.mysql_server_fqdn
}

output "mysql_database_name" {
  description = "The name of the MySQL database"
  value       = module.mysql.mysql_database_name
}

output "app_gateway_id" {
  description = "The ID of the Application Gateway"
  value       = module.appgateway.app_gateway_id
}

output "app_gateway_name" {
  description = "The name of the Application Gateway"
  value       = module.appgateway.app_gateway_name
}

output "app_gateway_public_ip" {
  description = "The public IP address of the Application Gateway"
  value       = module.appgateway.app_gateway_public_ip
}

output "app_gateway_private_ip" {
  description = "The private IP address of the Application Gateway"
  value       = module.appgateway.app_gateway_private_ip
}

output "aks_cluster_name" {
  description = "The name of the AKS cluster"
  value       = module.aks.cluster_name
}

output "aks_cluster_id" {
  description = "The ID of the AKS cluster"
  value       = module.aks.cluster_id
}

output "aks_kube_config" {
  description = "The Kubernetes configuration for the AKS cluster"
  value       = module.aks.kube_config
  sensitive   = true
}

output "aks_node_resource_group" {
  description = "The name of the resource group containing the AKS nodes"
  value       = module.aks.node_resource_group
}