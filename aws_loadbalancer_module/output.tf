output "bastion_sg_id" {
  value = aws_security_group.sglb2.id
}

output "app_sg_id" {
  value = aws_security_group.sglb1.id
}

output "id" {
  value = aws_elb.load_balancer.id
}