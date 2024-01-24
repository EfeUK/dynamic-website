# env variables

variable "name_prefix" {
  type    = string
  default = ""
}

variable "environment" {}

variable "aws_region" {}

variable "vpc_cidr" {
  description = "The IPv4 CIDR for the VPC."
  type        = string
}

variable "public_subnet_1a_cidr" {}

variable "public_subnet_1b_cidr" {}

variable "private_subnet_1a_cidr" {}

variable "private_subnet_1b_cidr" {}

variable "database_subnet_1a_cidr" {}

variable "database_subnet_1b_cidr" {}