infrastructure = {
  "rg-dev-microservice" = {
    location = "East US"
    tags = {
      environment = "dev"
      project     = "microservice-infra"
    }
    acrs = {
      "acrdevmicroservice" = {
        sku           = "Basic"
        admin_enabled = true
      }
    }
    aks_clusters = {
      "aks-dev-microservice" = {
        dns_prefix = "aksdev"
        default_node_pool = {
          name       = "default"
          node_count = 1
          vm_size    = "Standard_D2s_v3"
        }
        network_profile = {
          network_plugin    = "azure"
          network_policy    = "azure"
          load_balancer_sku = "standard"
        }
      }
    }
  }
}
