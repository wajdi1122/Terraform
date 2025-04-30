variable "location" {
  type        = string
  description = "Azure region where resources will be deployed"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "app_name" {
  type        = string
  description = "Name of the application"
}

variable "restart_policy" {
  type        = string
  default     = "Always"
  description = "Container restart policy"
  validation {
    condition     = contains(["Always", "Never", "OnFailure"], var.restart_policy)
    error_message = "Restart policy must be one of: Always, Never, OnFailure"
  }
}

# PostgreSQL configuration
variable "postgres_version" {
  type        = string
  default     = "latest"
  description = "PostgreSQL container image version"
}

variable "postgres_user" {
  type        = string
  description = "PostgreSQL admin username"
}

variable "postgres_password" {
  type        = string
  sensitive   = true
  description = "PostgreSQL admin password"
}

variable "postgres_db" {
  type        = string
  description = "PostgreSQL database name"
}

variable "db_cpu_cores" {
  type        = number
  default     = 1
  description = "CPU cores allocated to PostgreSQL container"
}

variable "db_memory_gb" {
  type        = number
  default     = 2
  description = "Memory (GB) allocated to PostgreSQL container"
}

# pgAdmin configuration
variable "pgadmin_version" {
  type        = string
  default     = "latest"
  description = "pgAdmin container image version"
}

variable "pgadmin_email" {
  type        = string
  description = "pgAdmin login email"
}

variable "pgadmin_password" {
  type        = string
  sensitive   = true
  description = "pgAdmin login password"
}

variable "pgadmin_cpu_cores" {
  type        = number
  default     = 0.5
  description = "CPU cores allocated to pgAdmin container"
}

variable "pgadmin_memory_gb" {
  type        = number
  default     = 1
  description = "Memory (GB) allocated to pgAdmin container"
}

# Backend configuration
variable "backend_image" {
  type        = string
  description = "Backend application container image"
}

variable "backend_cpu_cores" {
  type        = number
  default     = 1
  description = "CPU cores allocated to backend container"
}

variable "backend_memory_gb" {
  type        = number
  default     = 2
  description = "Memory (GB) allocated to backend container"
}

# Frontend configuration
variable "frontend_image" {
  type        = string
  description = "Frontend application container image"
}

variable "frontend_cpu_cores" {
  type        = number
  default     = 0.5
  description = "CPU cores allocated to frontend container"
}

variable "frontend_memory_gb" {
  type        = number
  default     = 1
  description = "Memory (GB) allocated to frontend container"
}

# Storage configuration
variable "storage_account_name" {
  type        = string
  description = "Name of the storage account for persistent volume"
}

variable "storage_share_name" {
  type        = string
  description = "Name of the file share for persistent volume"
}

variable "storage_account_key" {
  type        = string
  sensitive   = true
  description = "Access key for the storage account"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to resources"
}