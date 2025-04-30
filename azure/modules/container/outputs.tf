output "iovision_container_group_name" {
  value       = azurerm_container_group.iovision_app.name
  description = "Name of the container group"
}

output "iovision_container_group_id" {
  value       = azurerm_container_group.iovision_app.id
  description = "ID of the container group"
}

output "iovision_container_group_fqdn" {
  value       = azurerm_container_group.iovision_app.fqdn
  description = "Fully qualified domain name of the container group"
}

output "iovision_container_group_ip_address" {
  value       = azurerm_container_group.iovision_app.ip_address
  description = "Public IP address of the container group"
}

output "iovision_frontend_url" {
  value       = "http://${azurerm_container_group.iovision_app.fqdn}"
  description = "URL to access the frontend application"
}

output "iovision_pgadmin_url" {
  value       = "http://${azurerm_container_group.iovision_app.fqdn}:5050"
  description = "URL to access pgAdmin interface"
}

output "iovision_backend_url" {
  value       = "http://${azurerm_container_group.iovision_app.fqdn}:8080"
  description = "URL to access backend API"
}