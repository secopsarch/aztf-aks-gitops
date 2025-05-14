terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled

  network_rule_set {
    default_action = var.default_action
    ip_rule {
      action   = "Allow"
      ip_range = var.allowed_ip_ranges
    }
  }

  tags = var.tags
} 