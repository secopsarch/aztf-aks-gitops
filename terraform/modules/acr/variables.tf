variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where the ACR will be created"
  type        = string
}

variable "sku" {
  description = "SKU for the ACR (Basic, Standard, or Premium)"
  type        = string
  default     = "Standard"
}

variable "admin_enabled" {
  description = "Enable admin user for the ACR"
  type        = bool
  default     = true
}

variable "default_action" {
  description = "Default action for network rules (Allow or Deny)"
  type        = string
  default     = "Deny"
}

variable "allowed_ip_ranges" {
  description = "List of allowed IP ranges for network rules"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
} 