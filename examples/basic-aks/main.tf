provider "azurerm" {
  features {}
}

module "aks" {
  source = "../../terraform/modules/aks"

  cluster_name         = "example-aks"
  location            = "eastus"
  resource_group_name = "example-rg"
  dns_prefix         = "example-aks"
  kubernetes_version = "1.25.6"

  node_count = 2
  vm_size    = "Standard_D2s_v3"
  min_count  = 1
  max_count  = 3

  subnet_id = azurerm_subnet.aks.id

  tags = {
    Environment = "Example"
    ManagedBy   = "Terraform"
  }
}

# Basic networking setup for the example
resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "eastus"
}

resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "aks" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
} 