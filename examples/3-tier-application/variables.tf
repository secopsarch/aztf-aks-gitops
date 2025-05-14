variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "demo1-rg"
}

variable "environment" {
  description = "The environment name"
  type        = string
  default     = "demo1"
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "web_subnet_prefixes" {
  description = "The address prefixes for the web subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "app_subnet_prefixes" {
  description = "The address prefixes for the app subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "db_subnet_prefixes" {
  description = "The address prefixes for the database subnet"
  type        = list(string)
  default     = ["10.0.3.0/24"]
}

variable "private_dns_zone_name" {
  description = "The name of the private DNS zone"
  type        = string
  default     = "demo1.mysql.database.azure.com"
}

variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
  default     = "demo1acr"
}

variable "acr_sku" {
  description = "The SKU of the Azure Container Registry"
  type        = string
  default     = "Standard"
}

variable "mysql_server_name" {
  description = "The name of the MySQL server"
  type        = string
  default     = "demo1-mysql"
}

variable "mysql_database_name" {
  description = "The name of the MySQL database"
  type        = string
  default     = "demo1db"
}

variable "mysql_administrator_login" {
  description = "The administrator login for the MySQL server"
  type        = string
  default     = "demo1admin"
}

variable "mysql_administrator_password" {
  description = "The administrator password for the MySQL server"
  type        = string
  sensitive   = true
  default     = "Demo1@Password123" # In production, use a secure method to manage passwords
}

variable "mysql_storage_size_gb" {
  description = "The storage size in GB for the MySQL server"
  type        = number
  default     = 32
}

variable "mysql_sku_name" {
  description = "The SKU name for the MySQL server"
  type        = string
  default     = "B_Standard_B1ms"
}

variable "app_gateway_name" {
  description = "The name of the Application Gateway"
  type        = string
  default     = "demo1-appgateway"
}

variable "app_gateway_sku" {
  description = "The SKU of the Application Gateway"
  type        = string
  default     = "Standard_v2"
}

variable "app_gateway_sku_tier" {
  description = "SKU tier for the Application Gateway"
  type        = string
  default     = "Standard_v2"
}

variable "app_gateway_capacity" {
  description = "The capacity of the Application Gateway"
  type        = number
  default     = 2
}

variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
  default     = "demo1-aks"
}

variable "cluster_dns_prefix" {
  description = "The DNS prefix for the AKS cluster"
  type        = string
  default     = "demo1-aks"
}

variable "kubernetes_version" {
  description = "The version of Kubernetes for the AKS cluster"
  type        = string
  default     = "1.25.6"
}

variable "node_count" {
  description = "The number of nodes in the AKS cluster"
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "The size of the VMs in the AKS cluster"
  type        = string
  default     = "Standard_D2s_v3" # Standard_DS2_v2
}

variable "min_count" {
  description = "The minimum number of nodes in the AKS cluster"
  type        = number
  default     = 1
}

variable "max_count" {
  description = "The maximum number of nodes in the AKS cluster"
  type        = number
  default     = 2
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "demo1"
    ManagedBy   = "Terraform"
  }
}
