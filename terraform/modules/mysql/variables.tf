variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where the MySQL server will be created"
  type        = string
}

variable "server_name" {
  description = "Name of the MySQL Flexible Server"
  type        = string
}

variable "database_name" {
  description = "Name of the MySQL database"
  type        = string
}

variable "mysql_version" {
  description = "MySQL version"
  type        = string
  default     = "8.0.21"
}

variable "subnet_id" {
  description = "ID of the subnet where the MySQL server will be deployed"
  type        = string
}

variable "private_dns_zone_id" {
  description = "ID of the private DNS zone for MySQL"
  type        = string
}

variable "storage_size_gb" {
  description = "Storage size in GB"
  type        = number
  default     = 32
}

variable "backup_retention_days" {
  description = "Backup retention days"
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = "Enable geo-redundant backups"
  type        = bool
  default     = false
}

variable "administrator_login" {
  description = "Administrator login for MySQL server"
  type        = string
}

variable "administrator_password" {
  description = "Administrator password for MySQL server"
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "SKU name for the MySQL server"
  type        = string
  default     = "B_Standard_B1ms"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
} 