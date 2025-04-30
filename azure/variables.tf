# 🌍 Variables globales
variable "resource_group_name" {
  description = "Nom du Resource Group Azure"
  type        = string
  default     = "my-resource-group"
}
variable "vnet_address_space" {
  description = "The address space of the VNET"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "location" {
  description = "Région Azure"
  type        = string
  default     = "East US"
}

variable "pgadmin_email" {
  description = "Email pour PGAdmin"
  type        = string
}

variable "pgadmin_password" {
  description = "Mot de passe pour PGAdmin"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Mot de passe de la base de données"
  type        = string
  sensitive   = true
}

# 🌐 Variables pour le module VNET
variable "vnet_name" {
  description = "Nom du VNET"
  type        = string
  default     = "my-vnet"
}

# 🐳 Variables pour le module Container
variable "container_group_name" {
  description = "Nom du groupe de conteneur"
  type        = string
  default     = "my-container-group"
}

variable "container_image" {
  description = "Image Docker du conteneur"
  type        = string
  default     = "nginx:latest"
}

variable "container_port" {
  description = "Port exposé par le conteneur"
  type        = number
  default     = 80
}

variable "cpu" {
  description = "CPU alloué"
  type        = number
  default     = 1
}

variable "memory" {
  description = "Mémoire allouée (en Go)"
  type        = number
  default     = 1.5
}

variable "container_name" {
  description = "Nom du conteneur"
  type        = string
  default     = "my-container"
}

variable "tags" {
  description = "Tags à appliquer aux ressources"
  type        = map(string)
  default = {
    environment = "dev"
    project     = "pfe-cloud"
  }
}
