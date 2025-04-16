output "resource_group_name" {
  description = "The name of the resource group"
  value       = module.network.resource_group_name
}

output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = module.network.vnet_id
}

output "web_subnet_id" {
  description = "The ID of the web subnet"
  value       = module.network.web_subnet_id
}

output "app_subnet_id" {
  description = "The ID of the application subnet"
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
  description = "The ID of the Container Registry"
  value       = module.acr.acr_id
}

output "acr_login_server" {
  description = "The login server URL of the Container Registry"
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
  description = "The name of the MySQL server"
  value       = module.mysql.mysql_server_name
}

output "mysql_server_fqdn" {
  description = "The FQDN of the MySQL server"
  value       = module.mysql.mysql_server_fqdn
}

output "mysql_database_name" {
  description = "The name of the MySQL database"
  value       = module.mysql.mysql_database_name
}

output "application_gateway_id" {
  description = "The ID of the Application Gateway"
  value       = module.appgateway.application_gateway_id
}

output "application_gateway_ip" {
  description = "The public IP of the Application Gateway"
  value       = module.appgateway.public_ip_address
}

output "aks_cluster_name" {
  description = "The name of the AKS cluster"
  value       = module.aks.cluster_name
}

output "aks_cluster_id" {
  description = "The ID of the AKS cluster"
  value       = module.aks.cluster_id
}

output "kube_config" {
  description = "The kubeconfig for the AKS cluster"
  value       = module.aks.kube_config
  sensitive   = true
}

output "aks_node_resource_group" {
  description = "The name of the resource group containing the AKS nodes"
  value       = module.aks.node_resource_group
}

output "private_dns_zone_id" {
  description = "The ID of the Private DNS Zone"
  value       = module.private_dns.dns_zone_id
}

output "private_dns_zone_name" {
  description = "The name of the Private DNS Zone"
  value       = module.private_dns.dns_zone_name
}