variable "name_prefix" {
  type    = string
  default = ""
}

variable "mysql_db_identifier" {
  type    = string
  default = ""
}

variable "mysql_engine" {
  type        = string
  description = "The database engine to use"
  default     = "mysql"
}

variable "mysql_engine_version" {
  type        = string
  description = "The engine version to use"
}

variable "mysql_family" {
  type        = string
  description = "The family of the DB parameter group"
}

variable "mysql_major_engine_version" {
  type        = string
  description = "Specifies the major version of the engine that this option group should be associated with"
}

variable "mysql_auto_minor_version_upgrade" {
  type        = string
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window.."
  default     = true
}

variable "allow_major_version_upgrade" {
  type        = string
  description = "Indicates that major version upgrades are allowed."
  default     = true
}

variable "mysql_instance_class" {
  type        = string
  description = "The instance type of the RDS instance"
}

variable "allocated_storage" {
  type        = string
  description = "The allocated storage in gigabytes"
}

variable "max_allocated_storage" {
  type        = string
  description = "Specifies the value for Storage Autoscaling"
}

variable "mysql_db_name" {
  type        = string
  description = "The DB name to create. If omitted, no database is created initially"
}

variable "mysql_port" {
  type        = string
  description = "The port on which the DB accepts connections"
  default     = "3306"
}

variable "username" {
  type        = string
  description = "Username for the master DB user"
}

variable "maintenance_window" {
  type        = string
  description = "The window to perform maintenance in."
  default     = "Mon:00:00-Mon:03:00"
}

variable "backup_window" {
  type        = string
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled."
  default     = "03:00-06:00"
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  default     = "7"
}

variable "storage_type" {
  description = "standard (magnetic), gp2 (general purpose SSD), gp3 (general purpose SSD with IOPS), io1 (provisioned IOPS SSD)"
  default     = "gp3"
}

variable "iops" {
  description = "can only be set when storage_type is gp3 or io1"
  default     = "3000"
}

variable "storage_throughput" {
  description = "can only be set when storage_type is gp3 or io1"
  default     = "125"
}

variable "deletion_protection" {
  type        = bool
  description = "The database can't be deleted when this value is set to true"
  default     = true
}

variable "multi_az" {}

variable "storage_encrypted" {
  type        = string
  description = "Specifies whether the DB instance is encrypted."
  default     = true
}

variable "mysql_subnet_ids" {}

variable "create_db_subnet_group" {
  type    = bool
  default = true
}

variable "mysql_db_subnet_group_name" {
  type    = string
  default = ""
}

variable "mysql_option_group_name" {
  type    = string
  default = ""
}

variable "create_cloudwatch_log_group" {
  type    = bool
  default = true
}

variable "vpc_id" {
  default = ""
}

variable "vpc_cidr" {
  type    = string
  default = ""
}




variable "zone_id" {
  type    = string
  default = ""
}

variable "mysql_custom_endpoint" {
  default = ""
}

variable "record_ttl" {
  type    = number
  default = 300
}

variable "environment" {}

variable "tags" {}

variable "database_security_group_id" {}
