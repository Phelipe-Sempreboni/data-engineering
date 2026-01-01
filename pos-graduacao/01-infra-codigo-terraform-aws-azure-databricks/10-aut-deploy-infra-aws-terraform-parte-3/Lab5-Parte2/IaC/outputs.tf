# Definindo ALB DNS Output 
output "alb_dns_name" {
  value = aws_lb.ecs-alb.dns_name
}

