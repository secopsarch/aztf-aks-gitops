resource "azurerm_virtual_network" "ocplab_nw" {
  name                = var.vnet_name
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.ocplab_rg.name
}

resource "azurerm_subnet" "ocplab_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.ocplab_rg.name
  virtual_network_name = azurerm_virtual_network.ocplab_nw.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_public_ip" "ocplab_pip" {
  name                = "${var.vm_name}-pip"
  location            = var.location
  resource_group_name = azurerm_resource_group.ocplab_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "ocplab_vnic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.ocplab_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.ocplab_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ocplab_pip.id
  }
}

resource "azurerm_network_security_group" "ocplab_nsg" {
  name                = "${var.vm_name}-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.ocplab_rg.name
}

resource "azurerm_network_security_rule" "allow_ssh" {
  name                        = "allow-ssh-from-external"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.ocplab_rg.name
  network_security_group_name = azurerm_network_security_group.ocplab_nsg.name
}

resource "azurerm_network_interface_security_group_association" "ocplab_nic_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.ocplab_vnic.id
  network_security_group_id = azurerm_network_security_group.ocplab_nsg.id
}
