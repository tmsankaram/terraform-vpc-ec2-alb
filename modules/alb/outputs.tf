output "alb_dns" {
  description = "The DNS name of the ALB"
  value       = aws_alb.app.dns_name
}
