output "dns_zone_id" {
  description = "The ID of the Private DNS Zone"
  value       = azurerm_private_dns_zone.dns_zone.id
}

output "dns_zone_name" {
  description = "The name of the Private DNS Zone"
  value       = azurerm_private_dns_zone.dns_zone.name
}

output "dns_zone_number_of_record_sets" {
  description = "The number of record sets in the Private DNS Zone"
  value       = azurerm_private_dns_zone.dns_zone.number_of_record_sets
}

output "dns_zone_max_number_of_record_sets" {
  description = "The maximum number of record sets in the Private DNS Zone"
  value       = azurerm_private_dns_zone.dns_zone.max_number_of_record_sets
}

output "dns_zone_max_number_of_virtual_network_links" {
  description = "The maximum number of virtual network links in the Private DNS Zone"
  value       = azurerm_private_dns_zone.dns_zone.max_number_of_virtual_network_links
}

output "dns_zone_max_number_of_virtual_network_links_with_registration" {
  description = "The maximum number of virtual network links with registration in the Private DNS Zone"
  value       = azurerm_private_dns_zone.dns_zone.max_number_of_virtual_network_links_with_registration
} 