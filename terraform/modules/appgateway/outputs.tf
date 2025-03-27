output "app_gateway_id" {
  description = "The ID of the Application Gateway"
  value       = azurerm_application_gateway.app_gateway.id
}

output "app_gateway_name" {
  description = "The name of the Application Gateway"
  value       = azurerm_application_gateway.app_gateway.name
}

output "app_gateway_public_ip" {
  description = "The public IP address of the Application Gateway"
  value       = azurerm_public_ip.app_gateway_ip.ip_address
}

output "app_gateway_private_ip" {
  description = "The private IP address of the Application Gateway"
  value       = azurerm_application_gateway.app_gateway.private_ip_address
}

output "app_gateway_backend_address_pool_id" {
  description = "The ID of the backend address pool"
  value       = azurerm_application_gateway.app_gateway.backend_address_pool[0].id
} 