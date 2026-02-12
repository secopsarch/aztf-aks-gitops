# Updated Terraform configuration for CRC VM

# Variables file (variables.tf)
variable "ssh_public_key" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "pull_secret_path" {
  description = "Path to Red Hat pull secret"
  type        = string
  default     = "cloud-init/pull-secret.json"
}

# IMPORTANT: Validate pull secret exists
locals {
  # Read and validate pull secret
  pull_secret_content = fileexists(var.pull_secret_path) ? file(var.pull_secret_path) : ""

  # Ensure pull secret is valid JSON
  pull_secret_valid = try(jsondecode(local.pull_secret_content), null) != null
}

# Pre-deployment validation
resource "null_resource" "validate_pull_secret" {
  lifecycle {
    precondition {
      condition     = local.pull_secret_valid
      error_message = "Pull secret at ${var.pull_secret_path} is not valid JSON. Download from https://console.redhat.com/openshift/create/local"
    }
  }
}

# Main VM resource
resource "azurerm_linux_virtual_machine" "ocplab_vm" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = azurerm_resource_group.ocplab_rg.name
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.ocplab_vnic.id
  ]

  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.os_disk_size
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  # CORRECTED: Use indented() to properly format multi-line content
  custom_data = base64encode(
    templatefile("${path.module}/cloud-init/crc-bootstrap.yaml", {
      pull_secret = indent(6, local.pull_secret_content) # Properly indent JSON
      USER_NAME   = var.admin_username
      DISK        = "/dev/sdc"
      MOUNT       = "/labocp"
      CRC_BASE    = "/labocp/crc"
    })
  )

  # Ensure pull secret is validated first
  depends_on = [
    null_resource.validate_pull_secret
  ]

  tags = {
    Environment = "CRC-Lab"
    ManagedBy   = "Terraform"
    Purpose     = "OpenShift-Development"
  }
}

# Data disk
resource "azurerm_managed_disk" "data" {
  name                 = "${var.vm_name}-data"
  location             = var.location
  resource_group_name  = azurerm_resource_group.ocplab_rg.name
  storage_account_type = "Standard_LRS"
  disk_size_gb         = var.data_disk_size
  create_option        = "Empty"

  tags = {
    Environment = "CRC-Lab"
    ManagedBy   = "Terraform"
  }
}

# IMPORTANT: Attach disk and wait
resource "azurerm_virtual_machine_data_disk_attachment" "data" {
  managed_disk_id    = azurerm_managed_disk.data.id
  virtual_machine_id = azurerm_linux_virtual_machine.ocplab_vm.id
  lun                = 2
  caching            = "ReadWrite"

  # Ensure VM is fully created before attaching
  depends_on = [
    azurerm_linux_virtual_machine.ocplab_vm
  ]
}
