terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

# Custom data script for Ansible installation
locals {
  ansible_install_script = <<CUSTOM_DATA
#!/bin/bash

# Function to install Ansible on Ubuntu
install_ansible_ubuntu() {
    apt-get update
    apt-get install -y software-properties-common
    apt-add-repository --yes --update ppa:ansible/ansible
    apt-get install -y ansible
    apt-get install -y python3-pip
    pip3 install --upgrade pip
    pip3 install ansible
}

# Function to install Ansible on RedHat
install_ansible_redhat() {
    dnf install -y epel-release
    dnf install -y ansible
    dnf install -y python3-pip
    pip3 install --upgrade pip
    pip3 install ansible
}

# Detect OS and install Ansible
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VERSION=$VERSION_ID
fi

case $OS in
    "Ubuntu")
        install_ansible_ubuntu
        ;;
    "Red Hat Enterprise Linux")
        install_ansible_redhat
        ;;
    *)
        echo "Unsupported operating system: $OS"
        exit 1
        ;;
esac

# Create ansible user and setup SSH
useradd -m -s /bin/bash ansible
mkdir -p /home/ansible/.ssh
chmod 700 /home/ansible/.ssh

# Add ansible user to sudoers
echo "ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible
chmod 0440 /etc/sudoers.d/ansible

# Create authorized_keys file
touch /home/ansible/.ssh/authorized_keys
chmod 600 /home/ansible/.ssh/authorized_keys
chown -R ansible:ansible /home/ansible/.ssh

# Verify Ansible installation
ansible --version
CUSTOM_DATA
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.prefix}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space

  tags = var.tags
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_prefixes
}

# Public IPs
resource "azurerm_public_ip" "ubuntu1_pip" {
  name                = "${var.prefix}-ubuntu1-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  domain_name_label   = "${var.prefix}-ubuntu1"

  tags = var.tags
}

resource "azurerm_public_ip" "ubuntu2_pip" {
  name                = "${var.prefix}-ubuntu2-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  domain_name_label   = "${var.prefix}-ubuntu2"

  tags = var.tags
}

resource "azurerm_public_ip" "redhat_pip" {
  name                = "${var.prefix}-redhat-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  domain_name_label   = "${var.prefix}-redhat"

  tags = var.tags
}

# Network Interfaces
resource "azurerm_network_interface" "ubuntu1_nic" {
  name                = "${var.prefix}-ubuntu1-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ubuntu1_pip.id
  }

  tags = var.tags
}

resource "azurerm_network_interface" "ubuntu2_nic" {
  name                = "${var.prefix}-ubuntu2-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ubuntu2_pip.id
  }

  tags = var.tags
}

resource "azurerm_network_interface" "redhat_nic" {
  name                = "${var.prefix}-redhat-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.redhat_pip.id
  }

  tags = var.tags
}

# Network Interface Security Group Association
resource "azurerm_network_interface_security_group_association" "ubuntu1_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.ubuntu1_nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_interface_security_group_association" "ubuntu2_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.ubuntu2_nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_interface_security_group_association" "redhat_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.redhat_nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Ubuntu VMs
resource "azurerm_linux_virtual_machine" "ubuntu1" {
  name                = "${var.prefix}-ubuntu1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.ubuntu1_nic.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  custom_data = base64encode(local.ansible_install_script)

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "ubuntu2" {
  name                = "${var.prefix}-ubuntu2"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.ubuntu2_nic.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  custom_data = base64encode(local.ansible_install_script)

  tags = var.tags
}

# RedHat VM
resource "azurerm_linux_virtual_machine" "redhat" {
  name                = "${var.prefix}-redhat"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.redhat_nic.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "8-lvm-gen2"
    version   = "latest"
  }

  custom_data = base64encode(local.ansible_install_script)

  tags = var.tags
} 
