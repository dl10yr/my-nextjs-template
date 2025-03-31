output "endpoint" {
  value = "endpoint: http://${aws_lb.alb.dns_name}"
}

output "aws_lb_target_group_alb_arn" {
  value = aws_lb_target_group.alb.arn
}

output "aws_security_group_alb_id" {
  value = aws_security_group.alb.id
}

output "dns_name" {
  value = aws_lb.alb.dns_name
}

output "zone_id" {
  value = aws_lb.alb.zone_id
}

output "alb_name" {
  value = aws_lb.alb.name
}

output "alb_arn" {
  value = aws_lb.alb.arn
}
