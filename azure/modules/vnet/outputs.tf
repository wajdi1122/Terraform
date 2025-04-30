output "resource_group_name" {
  description = "Name of the Resource Group"
  value       = azurerm_resource_group.rg.name
}

output "virtual_network_id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.iovision_network.id
}

output "public_subnet_id" {
  description = "ID of subnet-1"
  value       = azurerm_subnet.iovision_public_subnet.id
}

output "private_subnet_id" {
  description = "ID of subnet-2"
  value       = azurerm_subnet.iovision_private_subnet.id
}

output "location" {
  description = "ID of subnet-2"
  value       = var.location
}
