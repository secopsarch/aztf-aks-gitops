variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "location" {
  description = "The Azure region where the AKS cluster will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the AKS cluster will be deployed"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use for the AKS cluster"
  type        = string
}

variable "node_count" {
  description = "The initial number of nodes in the node pool"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "The size of the Virtual Machine in the node pool"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "min_count" {
  description = "The minimum number of nodes in the node pool when auto-scaling"
  type        = number
  default     = 1
}

variable "max_count" {
  description = "The maximum number of nodes in the node pool when auto-scaling"
  type        = number
  default     = 5
}

variable "subnet_id" {
  description = "The ID of the subnet where the nodes will be deployed"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
} 