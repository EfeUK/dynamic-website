output "alb_security_group_id" {
  value = aws_security_group.alb_security_group.id
}

output "ecs_security_group_id" {
  value = aws_security_group.ecs_security_group.id
}

output "database_security_group_id" {
  value = aws_security_group.database_security_group.id
}

output "bastion_security_group_id" {
  value = aws_security_group.bastion_security_group.id
}