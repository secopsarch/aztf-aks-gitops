output "mysql_server_id" {
  description = "The ID of the MySQL Flexible Server"
  value       = azurerm_mysql_flexible_server.mysql.id
}

output "mysql_server_name" {
  description = "The name of the MySQL Flexible Server"
  value       = azurerm_mysql_flexible_server.mysql.name
}

output "mysql_server_fqdn" {
  description = "The fully qualified domain name of the MySQL Flexible Server"
  value       = azurerm_mysql_flexible_server.mysql.fqdn
}

output "mysql_database_name" {
  description = "The name of the MySQL database"
  value       = azurerm_mysql_flexible_database.database.name
}

output "mysql_administrator_login" {
  description = "The administrator login for the MySQL Flexible Server"
  value       = azurerm_mysql_flexible_server.mysql.administrator_login
}

output "mysql_administrator_password" {
  description = "The administrator password for the MySQL Flexible Server"
  value       = azurerm_mysql_flexible_server.mysql.administrator_password
  sensitive   = true
} 