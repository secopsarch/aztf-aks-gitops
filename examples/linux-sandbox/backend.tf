terraform {
  backend "azurerm" {
    resource_group_name  = "tf-statestorage-rg"
    storage_account_name = "azlabstatefilestorage"
    container_name       = "tfstatefiles"
    key                 = "linuxsandbox.terraform.tfstate"
  }
} 