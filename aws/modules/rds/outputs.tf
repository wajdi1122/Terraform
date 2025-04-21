output "rds_endpoint" {
  description = "Endpoint de la base de données RDS"
  value       = aws_db_instance.rds_instance.endpoint
}

output "rds_identifier" {
  description = "Nom de l'instance RDS"
  value       = aws_db_instance.rds_instance.id
}
