variable "infrastructure" {
  description = "A nested map defining the infrastructure to deploy"
  type = map(object({
    location = string
    tags     = optional(map(string), {})
    acrs = optional(map(object({
      sku           = optional(string, "Standard")
      admin_enabled = optional(bool, false)
      georeplications = optional(list(object({
        location                  = string
        zone_redundancy_enabled   = bool
        tags                      = map(string)
      })), [])
    })), {})
    aks_clusters = optional(map(object({
      kubernetes_version = optional(string, null)
      dns_prefix         = string
      default_node_pool = object({
        name       = string
        node_count = number
        vm_size    = string
      })
      network_profile = optional(object({
        network_plugin    = string
        load_balancer_sku = string
      }), null)
    })), {})
  }))
}
