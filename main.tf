provider "aws" {
  region  = "eu-west-1"
  profile = "efeuk"
}



module "vpc" {
  source                  = "./modules/vpc"
  name_prefix             = local.name_prefix
  environment             = local.environment
  aws_region              = local.aws_region
  vpc_cidr                = var.vpc_cidr
  public_subnet_1a_cidr   = var.public_subnet_1a_cidr
  public_subnet_1b_cidr   = var.public_subnet_1b_cidr
  private_subnet_1a_cidr  = var.private_subnet_1a_cidr
  private_subnet_1b_cidr  = var.private_subnet_1b_cidr
  database_subnet_1a_cidr = var.database_subnet_1a_cidr
  database_subnet_1b_cidr = var.database_subnet_1b_cidr

}

module "nat_gateway" {
  source                     = "./modules/nat-gateway"
  public_subnet_az1_id       = module.vpc.public_subnet_az1_id
  internet_gateway           = module.vpc.internet_gateway
  public_subnet_az2_id       = module.vpc.public_subnet_az2_id
  vpc_id                     = module.vpc.vpc_id
  private_app_subnet_az1_id  = module.vpc.private_app_subnet_az1_id
  private_data_subnet_az1_id = module.vpc.private_data_subnet_az1_id
  private_app_subnet_az2_id  = module.vpc.private_app_subnet_az2_id
  private_data_subnet_az2_id = module.vpc.private_data_subnet_az2_id
  environment                = local.environment
  name_prefix                = local.name_prefix
}

module "security-groups" {
  source      = "./modules/security-groups"
  vpc_id      = module.vpc.vpc_id
  environment = local.environment
  name_prefix = local.name_prefix
  ssh_ip      = var.ssh_ip
}

module "rds" {
  source                     = "./modules/rds"
  name_prefix                = local.name_prefix
  environment                = local.environment
  mysql_engine_version       = var.mysql_engine_version
  username                   = "administrator"
  mysql_family               = var.mysql_family
  mysql_major_engine_version = var.mysql_major_engine_version
  mysql_instance_class       = var.mysql_instance_class
  allocated_storage          = "20"
  max_allocated_storage      = "100"
  storage_type               = "gp3"
  mysql_db_name              = var.mysql_db_name
  multi_az                   = var.multi_az
  backup_retention_period    = var.backup_retention_period
  vpc_id                     = module.vpc.vpc_id
  mysql_subnet_ids           = var.mysql_subnet_ids
  mysql_db_subnet_group_name = var.mysql_db_subnet_group_name
  # mysql_parameter_group_name       = var.mysql_parameter_group_name
  mysql_option_group_name    = var.mysql_option_group_name
  # vpc_cidr                   = module.vpc_cidr
  zone_id                    = var.zone_id
  mysql_custom_endpoint      = var.mysql_custom_endpoint
  mysql_db_identifier        = "dynamic-web"
  database_security_group_id = module.security-groups.database_security_group_id
  tags                       = local.common_tags
}
