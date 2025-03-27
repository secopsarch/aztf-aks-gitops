variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "zone_name" {
  description = "The name of the Private DNS Zone"
  type        = string
}

variable "virtual_network_ids" {
  description = "List of Virtual Network IDs to link with the Private DNS Zone"
  type        = list(string)
  default     = []
}

variable "registration_enabled" {
  description = "Whether to enable auto-registration of virtual networks"
  type        = bool
  default     = true
}

variable "a_records" {
  description = "Map of A records to create"
  type = map(object({
    ttl     = number
    records = list(string)
  }))
  default = {}
}

variable "cname_records" {
  description = "Map of CNAME records to create"
  type = map(object({
    ttl    = number
    record = string
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
} 