terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
  # Terraform State Storage to Azure Storage Container
  backend "azurerm" {
    resource_group_name  = "tf-statestorage-rg"
    storage_account_name = "azlabstatefilestorage"
    container_name       = "k8statefiles"
    key                  = "flask-app.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Common variables
locals {
  location            = var.location
  resource_group_name = var.resource_group_name
  environment         = var.environment
  tags = {
    Environment = local.environment
    ManagedBy   = "Terraform"
    Project     = "3-Tier-App"
  }
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = local.location
  tags     = local.tags
}

# Network Module
module "network" {
  source = "../../terraform/modules/network"

  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location
  address_space       = var.address_space
  web_subnet_prefixes = var.web_subnet_prefixes
  app_subnet_prefixes = var.app_subnet_prefixes
  db_subnet_prefixes  = var.db_subnet_prefixes
  tags                = local.tags
}

# Private DNS Zone Module
module "private_dns" {
  source = "../../terraform/modules/private_dns"

  resource_group_name  = azurerm_resource_group.rg.name
  zone_name           = var.private_dns_zone_name
  virtual_network_ids = [module.network.vnet_id]
  registration_enabled = true
  a_records = {
    "mysql" = {
      ttl     = 300
      records = [module.mysql.mysql_server_private_ip]
    }
  }
  tags = local.tags
}

# ACR Module
module "acr" {
  source = "../../terraform/modules/acr"

  acr_name            = var.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location
  sku                 = var.acr_sku
  admin_enabled       = true
  tags                = local.tags
}

# MySQL Module
module "mysql" {
  source = "../../terraform/modules/mysql"

  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location
  server_name         = var.mysql_server_name
  database_name       = var.mysql_database_name
  subnet_id           = module.network.db_subnet_id
  private_dns_zone_id = module.private_dns.dns_zone_id

  administrator_login    = var.mysql_administrator_login
  administrator_password = var.mysql_administrator_password

  storage_size_gb = var.mysql_storage_size_gb
  sku_name        = var.mysql_sku_name
  tags            = local.tags
}

# Application Gateway Module
module "appgateway" {
  source = "../../terraform/modules/appgateway"

  app_gateway_name    = var.app_gateway_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = local.location
  subnet_id           = module.network.web_subnet_id
  sku_name            = var.app_gateway_sku
  sku_tier            = var.app_gateway_sku_tier
  capacity            = var.app_gateway_capacity
  backend_fqdns       = []
  tags                = local.tags
}

# AKS Module
module "aks" {
  source = "../../terraform/modules/aks"

  cluster_name        = var.cluster_name
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix         = var.cluster_dns_prefix
  kubernetes_version = var.kubernetes_version

  node_count = var.node_count
  vm_size    = var.vm_size
  min_count  = var.min_count
  max_count  = var.max_count

  subnet_id = module.network.app_subnet_id
  tags      = local.tags

  depends_on = [
    module.network,
    module.acr
  ]
}
