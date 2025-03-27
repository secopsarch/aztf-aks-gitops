variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where the network will be created"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "web_subnet_prefixes" {
  description = "Address prefixes for the web subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "app_subnet_prefixes" {
  description = "Address prefixes for the application subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "db_subnet_prefixes" {
  description = "Address prefixes for the database subnet"
  type        = list(string)
  default     = ["10.0.3.0/24"]
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
} 