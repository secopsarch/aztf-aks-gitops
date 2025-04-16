terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

resource "azurerm_private_dns_zone" "dns_zone" {
  name                = var.zone_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  count                 = length(var.virtual_network_ids)
  name                  = "link-${count.index + 1}"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone.name
  virtual_network_id    = var.virtual_network_ids[count.index]
  registration_enabled  = var.registration_enabled
  tags                  = var.tags
}

resource "azurerm_private_dns_a_record" "a_records" {
  for_each            = var.a_records
  name                = each.key
  zone_name           = azurerm_private_dns_zone.dns_zone.name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = var.tags
}

resource "azurerm_private_dns_cname_record" "cname_records" {
  for_each            = var.cname_records
  name                = each.key
  zone_name           = azurerm_private_dns_zone.dns_zone.name
  resource_group_name = var.resource_group_name
  ttl                 = each.value.ttl
  record              = each.value.record
  tags                = var.tags
} 