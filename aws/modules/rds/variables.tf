variable "subnet_ids" {
  description = "Liste des subnets privés pour le RDS"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group autorisant l'accès à RDS"
  type        = string
}

variable "db_name" {
  description = "Nom de la base de données"
  type        = string
  default     = "iovisiondb"
}

variable "db_username" {
  description = "Nom d'utilisateur RDS"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Mot de passe RDS"
  type        = string
  sensitive   = true
}
