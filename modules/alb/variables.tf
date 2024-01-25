variable "name_prefix" {
  type    = string
  default = ""
}

variable "environment" {}

variable "alb_security_group_id" {}
variable "public_subnet_az1_id" {}
variable "public_subnet_az2_id" {}
variable "target_type" {}
variable "vpc_id" {}
variable "certificate_arn" {}