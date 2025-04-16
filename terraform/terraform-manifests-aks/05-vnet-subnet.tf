resource "azurerm_virtual_network" "vnet" {
  name                = "aks-vnet"
  address_space       = ["10.20.0.0/16"]
  location           = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.20.100.0/24"]
}
