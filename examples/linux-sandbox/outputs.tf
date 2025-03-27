output "resource_group_name" {
  description = "The name of the resource group"
  value       = module.linux_vms.resource_group_name
}

output "vnet_id" {
  description = "The ID of the virtual network"
  value       = module.linux_vms.vnet_id
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = module.linux_vms.subnet_id
}

output "ubuntu1_public_ip" {
  description = "The public IP address of Ubuntu VM 1"
  value       = module.linux_vms.ubuntu1_public_ip
}

output "ubuntu2_public_ip" {
  description = "The public IP address of Ubuntu VM 2"
  value       = module.linux_vms.ubuntu2_public_ip
}

output "redhat_public_ip" {
  description = "The public IP address of RedHat VM"
  value       = module.linux_vms.redhat_public_ip
}

output "ubuntu1_private_ip" {
  description = "The private IP address of Ubuntu VM 1"
  value       = module.linux_vms.ubuntu1_private_ip
}

output "ubuntu2_private_ip" {
  description = "The private IP address of Ubuntu VM 2"
  value       = module.linux_vms.ubuntu2_private_ip
}

output "redhat_private_ip" {
  description = "The private IP address of RedHat VM"
  value       = module.linux_vms.redhat_private_ip
} 