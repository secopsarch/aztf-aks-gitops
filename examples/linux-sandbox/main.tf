terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tf-statestorage-rg"
    storage_account_name = "azlabstatefilestorage"
    container_name       = "tfstatefiles"
    key                  = "linuxsandbox.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "01bfbbdc-7cd9-42c4-9f81-fcd897c18fa8"
}

# Common variables
locals {
  location            = var.location
  resource_group_name = var.resource_group_name
  environment         = var.environment
  tags = {
    Environment = local.environment
    ManagedBy   = "Terraform"
    Project     = "LinuxSandbox"
  }
}

# Linux VMs Module
module "linux_vms" {
  source = "../../terraform/modules/linux_vms"

  resource_group_name = local.resource_group_name
  location            = local.location
  prefix              = var.prefix
  address_space       = var.address_space
  subnet_prefixes     = var.subnet_prefixes
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  ssh_public_key      = var.ssh_public_key
  tags                = local.tags
}
