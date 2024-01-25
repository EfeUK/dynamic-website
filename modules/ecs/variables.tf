
variable "name_prefix" {
  type    = string
  default = ""
}

variable "environment" {}

variable "ecs_task_execution_role_arn" {}

variable "architecture" {}

variable "container_image" {}
variable "dynamic_website_bucket" {}
variable "dynamic_file" {}
variable "aws_region" {}
variable "private_app_subnet_az1_id" {}
variable "private_app_subnet_az2_id" {}
variable "ecs_security_group_id" {}
variable "alb_target_group_arn" {}
variable "ecs_cluster" {}
# variable "app_port" {}