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

variable "public_subnet_1a.cidr" {}

variable "public_subnet_1b.cidr" {}

variable "private_subnet_1a.cidr" {}

variable "private_subnet_1b.cidr" {}

variable "database_subnet_1a.cidr" {}

variable "database_subnet_1b.cidr" {}