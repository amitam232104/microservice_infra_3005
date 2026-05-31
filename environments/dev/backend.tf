terraform {
  backend "azurerm" {
    # Replace these with your actual Azure Storage Account details
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "stterraformstateprod" # Must be globally unique
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
    
    # Enables OIDC authentication for the backend
    use_oidc = true
  }
}
