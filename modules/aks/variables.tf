variable "aks_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region for the AKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Version of Kubernetes to use"
  type        = string
  default     = null
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "default_node_pool" {
  description = "Default node pool configuration"
  type = object({
    name       = string
    node_count = number
    vm_size    = string
  })
}

variable "network_profile" {
  description = "Network profile configuration"
  type = object({
    network_plugin    = string
    load_balancer_sku = string
  })
  default = null
}

variable "tags" {
  description = "Tags to assign to the AKS cluster"
  type        = map(string)
  default     = {}
}
