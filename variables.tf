variable "environment" {}

variable "name_prefix" {
  type    = string
  default = ""
}

variable "aws_region" {}

variable "vpc_cidr" {}

variable "vpc_id" {}

variable "public_subnet_1a_cidr" {}

variable "public_subnet_1b_cidr" {}

variable "private_subnet_1a_cidr" {}

variable "private_subnet_1b_cidr" {}

variable "database_subnet_1a_cidr" {}

variable "database_subnet_1b_cidr" {}

variable "ssh_ip" {}

# RDS Database variables

variable "mysql_engine_version" {}

variable "mysql_major_engine_version" {}

variable "mysql_family" {}

variable "mysql_instance_class" {}

variable "mysql_db_name" {}

variable "multi_az" {}

variable "backup_retention_period" {}

variable "mysql_subnet_ids" {}

variable "mysql_db_subnet_group_name" {}


variable "mysql_option_group_name" {}

variable "mysql_custom_endpoint" {}

variable "zone_id" {}