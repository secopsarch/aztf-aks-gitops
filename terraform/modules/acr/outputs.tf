output "acr_id" {
  description = "The ID of the Container Registry"
  value       = azurerm_container_registry.acr.id
}

output "acr_login_server" {
  description = "The login server URL for the Container Registry"
  value       = azurerm_container_registry.acr.login_server
}

output "acr_username" {
  description = "The username for the Container Registry"
  value       = azurerm_container_registry.acr.admin_username
}

output "acr_password" {
  description = "The password for the Container Registry"
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
} 