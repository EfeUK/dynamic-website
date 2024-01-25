variable "environment" {}

variable "name_prefix" {
  type    = string
  default = ""
}

variable "aws_region" {}

variable "vpc_cidr" {}

variable "vpc_id" {} # comment out when applying only vpc

variable "public_subnet_1a_cidr" {}

variable "public_subnet_1b_cidr" {}

variable "private_subnet_1a_cidr" {}

variable "private_subnet_1b_cidr" {}

variable "database_subnet_1a_cidr" {}

variable "database_subnet_1b_cidr" {}

# Security Group

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


# variable "mysql_option_group_name" {}

variable "mysql_custom_endpoint" {}

variable "zone_id" {}

# acm variables

variable "domain_name" {}
variable "alternative_names" {}

# alb variables

variable "target_type" {}

# s3 variables

variable "dynamic_website_bucket" {}
variable "dynamic_file" {}

# # ecs variables

variable "architecture" {}
variable "container_image" {}
variable "ecs_cluster" {}
# variable "app_port" {}

# # route-53 variables

variable "record_name" {}




