output "alb_dns_name" {
  value = aws_lb.app_lb.dns_name
}

output "autoscaling_group" {
  value = aws_autoscaling_group.asg.arn
}
