output "acr_name" {
  description = "The name of the ACR"
  value       = azurerm_container_registry.this.name
}

output "acr_id" {
  description = "The ID of the ACR"
  value       = azurerm_container_registry.this.id
}

output "acr_login_server" {
  description = "The login server for the ACR"
  value       = azurerm_container_registry.this.login_server
}
