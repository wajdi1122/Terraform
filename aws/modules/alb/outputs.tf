output "alb_dns_name" {
  description = "Nom DNS du Load Balancer"
  value       = aws_lb.alb.dns_name
}

output "target_group_arn" {
  description = "ARN du target group"
  value       = aws_lb_target_group.tg.arn
}

output "alb_arn" {
  description = "ARN du Load Balancer"
  value       = aws_lb.alb.arn
}
