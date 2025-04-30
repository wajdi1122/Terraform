
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region for resources"
}

variable "frontend_subnet_id" {
  type        = string
  description = "ID of the frontend subnet for Application Gateway"
}

variable "backend_subnet_id" {
  type        = string
  description = "ID of the backend subnet for VMs"
}

variable "sku_name" {
  type        = string
  default     = "Standard_v2"
  description = "Application Gateway SKU name"
}

variable "sku_tier" {
  type        = string
  default     = "Standard_v2"
  description = "Application Gateway SKU tier"
}

variable "capacity" {
  type        = number
  default     = 2
  description = "Application Gateway capacity"
}

variable "frontend_port" {
  type        = number
  default     = 80
  description = "Frontend port number"
}

variable "backend_port" {
  type        = number
  default     = 80
  description = "Backend port number"
}

variable "request_timeout" {
  type        = number
  default     = 60
  description = "Request timeout in seconds"
}

variable "rule_priority" {
  type        = number
  default     = 1
  description = "Rule priority"
}

variable "backend_vm_count" {
  type        = number
  default     = 2
  description = "Number of backend VMs"
}

variable "vm_size" {
  type        = string
  default     = "Standard_DS1_v2"
  description = "VM size"
}

variable "vm_admin_username" {
  type        = string
  default     = "azureadmin"
  description = "VM admin username"
}

variable "vm_image_sku" {
  type        = string
  default     = "2019-Datacenter"
  description = "Windows Server image SKU"
}

variable "prefix" {
  description = "Préfixe utilisé pour nommer toutes les ressources de ce module"
  type        = string
  default = "iovison"
}
