
module "db" {
  source                              = "terraform-aws-modules/rds/aws"
  version                             = "5.9.0"
  identifier                          = "${var.name_prefix}-${var.environment}-${var.mysql_db_identifier}"
  engine                              = var.mysql_engine
  engine_version                      = var.mysql_engine_version
  family                              = var.mysql_family
  major_engine_version                = var.mysql_major_engine_version
  instance_class                      = var.mysql_instance_class
  allocated_storage                   = var.allocated_storage
  max_allocated_storage               = var.max_allocated_storage
  db_name                             = var.mysql_db_name
  port                                = var.mysql_port
  username                            = var.username
  password                            = random_password.master_password.result
  create_random_password              = false
  vpc_security_group_ids              = [var.database_security_group_id]
  maintenance_window                  = var.maintenance_window
  backup_window                       = var.backup_window
  backup_retention_period             = var.backup_retention_period
  auto_minor_version_upgrade          = var.mysql_auto_minor_version_upgrade
  deletion_protection                 = var.deletion_protection
  multi_az                            = var.multi_az
  storage_encrypted                   = var.storage_encrypted
  storage_type                        = var.storage_type
  skip_final_snapshot                 = true
  subnet_ids                          = var.mysql_subnet_ids
  create_db_subnet_group              = var.create_db_subnet_group
  db_subnet_group_name                = var.mysql_db_subnet_group_name
  option_group_name                   = var.mysql_option_group_name
  publicly_accessible                 = false
  
  
  # Enhanced Monitoring
  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60
  monitoring_role_name                  = "${var.environment}-${var.mysql_db_identifier}-monitoring-role"
  monitoring_role_use_name_prefix       = true
  monitoring_role_description           = "MySQL monitoring role"
  create_cloudwatch_log_group           = var.create_cloudwatch_log_group
  enabled_cloudwatch_logs_exports       = ["audit", "error", "general", "slowquery"]

  parameters = [
    {
      name = "character_set_client"
      value = "utf8mb4"
    },
    {
      name = "character_set_server"
      value = "utf8mb4"
    }
  ]
  tags = var.tags
  db_option_group_tags = {
    "Sensitive" = "low"
  }
  db_parameter_group_tags = {
    "Sensitive" = "low"
  }
}


resource "random_password" "master_password" {
  length           = 12
  upper            = true
  lower            = true
  numeric          = true
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# resource "aws_secretsmanager_secret" "mysql_secret" {
#   description = "Secret for storing master username/password"
#   name        = "${var.name_prefix}-${var.environment}-${var.mysql_db_identifier}-secret"
#   tags        = var.tags
# }