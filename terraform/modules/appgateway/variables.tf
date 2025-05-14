variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where the Application Gateway will be created"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where the Application Gateway will be deployed"
  type        = string
}

variable "backend_fqdns" {
  description = "List of FQDNs for the backend pool"
  type        = list(string)
  default     = []
}

variable "backend_port" {
  description = "Port for the backend HTTP settings"
  type        = number
  default     = 80
}
#variable "app_gateway_name" {
#  description = "The name of the Application Gateway"
#  type        = string
#  default     = "demo1-appgateway"
#}
variable "sku_name" {
  description = "SKU name for the Application Gateway"
  type        = string
  default     = "Standard_v2"
}

variable "sku_tier" {
  description = "SKU tier for the Application Gateway"
  type        = string
  default     = "Standard_v2"
}

variable "capacity" {
  description = "Capacity for the Application Gateway"
  type        = number
  default     = 2
}

variable "public_ip_sku" {
  description = "SKU for the public IP"
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
} 
