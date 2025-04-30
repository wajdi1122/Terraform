variable "sql_server_name" {
  description = "Name of the SQL server"
  type        = string
}

variable "sql_database_name" {
  description = "Name of the SQL database"
  type        = string
}

variable "admin_username" {
  description = "Administrator username for the SQL server"
  type        = string
}

variable "admin_password" {
  description = "Administrator password for the SQL server"
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "sku_name" {
  description = "SKU name for the SQL database"
  type        = string
}

variable "sku_tier" {
  description = "SKU tier for the SQL database"
  type        = string
}

variable "sku_capacity" {
  description = "Capacity for the SQL database"
  type        = number
}

variable "tags" {
  description = "Tags to assign to the SQL server and database"
  type        = map(string)
}
