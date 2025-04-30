output "application_gateway_id" {
  description = "ID of the Application Gateway"
  value       = azurerm_application_gateway.iovison_gateway.id
}

output "application_gateway_public_ip" {
  description = "Public IP of the App Gateway"
  value       = azurerm_public_ip.agw_pip.ip_address
}

output "backend_vm_names" {
  description = "Names of the backend VMs"
  value       = azurerm_windows_virtual_machine.backend_vm[*].name
}

output "backend_vm_private_ips" {
  description = "Private IPs of the backend VMs"
  value       = azurerm_network_interface.backend_nic[*].private_ip_address
}
