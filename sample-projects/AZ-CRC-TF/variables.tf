variable "resource_group_name" {
  type    = string
  default = "ocplab-centralus"
}

variable "location" {
  type    = string
  default = "centralus"
}

variable "vnet_name" {
  type    = string
  default = "vnet-centralus"
}

variable "subnet_name" {
  type    = string
  default = "snet-centralus-1"
}

variable "vm_name" {
  type    = string
  default = "labocpserver"
}

variable "vm_size" {
  type    = string
  default = "Standard_D4s_v3"
}

variable "admin_username" {
  type    = string
  default = "ocpadm"
}

# variable "pull_secret_path" {
#   type        = string
#   description = "Path to OpenShift pull secret"
# }

# variable "ssh_public_key" {
#   type = string
# }

variable "os_disk_size" {
  type    = number
  default = 64
}

variable "data_disk_size" {
  type    = number
  default = 128
}
