locals {
  # Flattening ACRs from the nested map
  acrs_flat = flatten([
    for rg_key, rg_val in var.infrastructure : [
      for acr_key, acr_val in rg_val.acrs : {
        rg_key   = rg_key
        acr_key  = acr_key
        location = rg_val.location
        acr_data = acr_val
      }
    ]
  ])

  # Flattening AKS clusters from the nested map
  aks_flat = flatten([
    for rg_key, rg_val in var.infrastructure : [
      for aks_key, aks_val in rg_val.aks_clusters : {
        rg_key   = rg_key
        aks_key  = aks_key
        location = rg_val.location
        aks_data = aks_val
      }
    ]
  ])
}

# 1. Create Resource Groups
module "resource_groups" {
  source   = "../../modules/resource_group"
  for_each = var.infrastructure

  resource_group_name = each.key
  location            = each.value.location
  tags                = each.value.tags
}

# 2. Create ACRs
module "acrs" {
  source   = "../../modules/acr"
  for_each = { for acr in local.acrs_flat : "${acr.rg_key}.${acr.acr_key}" => acr }

  acr_name            = each.value.acr_key
  resource_group_name = module.resource_groups[each.value.rg_key].resource_group_name
  location            = each.value.location
  sku                 = each.value.acr_data.sku
  admin_enabled       = each.value.acr_data.admin_enabled
  georeplications     = each.value.acr_data.georeplications
  tags                = var.infrastructure[each.value.rg_key].tags
}

# 3. Create AKS Clusters
module "aks_clusters" {
  source   = "../../modules/aks"
  for_each = { for aks in local.aks_flat : "${aks.rg_key}.${aks.aks_key}" => aks }

  aks_name            = each.value.aks_key
  resource_group_name = module.resource_groups[each.value.rg_key].resource_group_name
  location            = each.value.location
  kubernetes_version  = each.value.aks_data.kubernetes_version
  dns_prefix          = each.value.aks_data.dns_prefix
  default_node_pool   = each.value.aks_data.default_node_pool
  network_profile     = each.value.aks_data.network_profile
  tags                = var.infrastructure[each.value.rg_key].tags
}
