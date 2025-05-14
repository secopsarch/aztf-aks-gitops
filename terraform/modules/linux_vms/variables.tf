variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "eastus"
}

variable "prefix" {
  description = "Prefix for all resource names"
  type        = string
  default     = "sandbox"
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_prefixes" {
  description = "The address prefixes for the subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vm_size" {
  description = "The size of the VMs"
  type        = string
  default     = "Standard_B1s"  # Low cost VM size
}

variable "admin_username" {
  description = "The admin username for the VMs"
  type        = string
  default     = "adminuser"
}

variable "ssh_public_key" {
  description = "The SSH public key for VM access"
  default = ""
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
} 
