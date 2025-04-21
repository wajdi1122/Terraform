variable "container_image" {
  description = "Image Docker pour ECS"
  type        = string
}

variable "target_group_arn" {
  description = "ARN du target group de l'ALB"
  type        = string
}

variable "subnets" {
  description = "Liste des subnets pour ECS"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID du Security Group à associer"
  type        = string
}
