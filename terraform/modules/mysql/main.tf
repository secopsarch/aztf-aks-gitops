terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

# MySQL Flexible Server
resource "azurerm_mysql_flexible_server" "mysql" {
  name                = var.server_name
  resource_group_name = var.resource_group_name
  location            = var.location
  version            = var.mysql_version

  delegated_subnet_id = var.subnet_id
  private_dns_zone_id = var.private_dns_zone_id

  storage {
    size_gb = var.storage_size_gb
  }

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  administrator_login    = var.administrator_login
  administrator_password = var.administrator_password

  sku_name = var.sku_name

  tags = var.tags
}

# MySQL Flexible Server Database
resource "azurerm_mysql_flexible_database" "database" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql.name
  charset             = "utf8mb4"
  collation          = "utf8mb4_unicode_ci"
}

# MySQL Flexible Server Firewall Rule
resource "azurerm_mysql_flexible_server_firewall_rule" "firewall" {
  name                = "allow-azure-services"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.mysql.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
} 