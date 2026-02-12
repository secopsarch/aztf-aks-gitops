resource "azurerm_resource_group" "ocplab_rg" {
  name     = var.resource_group_name
  location = var.location
}
