########################
# Resource Group
########################
output "resource_group_name" {
  description = "Azure Resource Group name"
  value       = azurerm_resource_group.ocplab_rg.name
}

output "resource_group_location" {
  description = "Azure region"
  value       = azurerm_resource_group.ocplab_rg.location
}

########################
# Virtual Network
########################
output "vnet_name" {
  description = "Virtual Network name"
  value       = azurerm_virtual_network.ocplab_nw.name
}

output "vnet_address_space" {
  description = "VNet CIDR"
  value       = azurerm_virtual_network.ocplab_nw.address_space
}

output "subnet_name" {
  description = "Subnet name"
  value       = azurerm_subnet.ocplab_subnet.name
}



########################
# Network Interface
########################

output "private_ip" {
  description = "Private IP address of the VM"
  value       = azurerm_network_interface.ocplab_vnic.private_ip_address
}

output "public_ip" {
  description = "Public IP address (if assigned)"
  value       = try(azurerm_public_ip.ocplab_pip.ip_address, null)
}

########################
# Virtual Machine
########################
output "vm_name" {
  description = "Linux VM name"
  value       = azurerm_linux_virtual_machine.ocplab_vm.name
}

output "vm_size" {
  description = "VM SKU"
  value       = azurerm_linux_virtual_machine.ocplab_vm.size
}

output "admin_username" {
  description = "Admin username for VM"
  value       = azurerm_linux_virtual_machine.ocplab_vm.admin_username
}

output "hostname" {
  description = "Hostname inside VM"
  value       = azurerm_linux_virtual_machine.ocplab_vm.computer_name
}
