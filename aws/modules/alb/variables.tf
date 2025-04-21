variable "vpc_id" {
  description = "ID de la VPC"
  type        = string
}

variable "subnets" {
  description = "Liste des subnets publics"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID du Security Group pour le Load Balancer"
  type        = string
}
