output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "vnet_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.subnet.id
}

output "ubuntu1_public_ip" {
  description = "The public IP address of Ubuntu VM 1"
  value       = azurerm_public_ip.ubuntu1_pip.ip_address
}

output "ubuntu2_public_ip" {
  description = "The public IP address of Ubuntu VM 2"
  value       = azurerm_public_ip.ubuntu2_pip.ip_address
}

output "redhat_public_ip" {
  description = "The public IP address of RedHat VM"
  value       = azurerm_public_ip.redhat_pip.ip_address
}

output "ubuntu1_private_ip" {
  description = "The private IP address of Ubuntu VM 1"
  value       = azurerm_network_interface.ubuntu1_nic.private_ip_address
}

output "ubuntu2_private_ip" {
  description = "The private IP address of Ubuntu VM 2"
  value       = azurerm_network_interface.ubuntu2_nic.private_ip_address
}

output "redhat_private_ip" {
  description = "The private IP address of RedHat VM"
  value       = azurerm_network_interface.redhat_nic.private_ip_address
} 