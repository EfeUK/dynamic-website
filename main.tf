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




# request ssl certificate

module "ssl_certificate" {
  source            = "./modules/acm"
  domain_name       = var.domain_name
  alternative_names = var.alternative_names
}

# Creation of pplication load balancer

module "application_load_balancer" {
  source                = "./modules/alb"
  name_prefix           = local.name_prefix
  environment           = local.environment
  alb_security_group_id = module.security-groups.alb_security_group_id
  public_subnet_az1_id  = module.vpc.public_subnet_az1_id
  public_subnet_az2_id  = module.vpc.public_subnet_az2_id
  target_type           = var.target_type
  vpc_id                = module.vpc.vpc_id
  certificate_arn       = module.ssl_certificate.certificate_arn
}

# Create s3 bucket

module "aws_s3_bucket" {
  source                 = "./modules/s3"
  name_prefix            = local.name_prefix
  dynamic_website_bucket = var.dynamic_website_bucket
  dynamic_file           = var.dynamic_file

}

# # create ecs task execution role

module "ecs_task_execution_role" {
  source                 = "./modules/iam-role"
  name_prefix            = local.name_prefix
  environment            = local.environment
  dynamic_website_bucket = var.dynamic_website_bucket
}

# create ecs and task definitions
module "ecs" {
  source                      = "./modules/ecs"
  name_prefix                 = local.name_prefix
  environment                 = local.environment
  ecs_task_execution_role_arn = module.ecs_task_execution_role.ecs_task_execution_role_arn
  architecture                = var.architecture
  container_image             = var.container_image
  dynamic_website_bucket      = var.dynamic_website_bucket # check all related later in main.tf, could switch to module.aws_s3_bucket
  dynamic_file                = var.dynamic_file
  aws_region                  = local.aws_region
  private_app_subnet_az1_id   = module.vpc.private_app_subnet_az1_id
  private_app_subnet_az2_id   = module.vpc.private_app_subnet_az2_id
  ecs_security_group_id       = module.security-groups.ecs_security_group_id
  alb_target_group_arn        = module.application_load_balancer.alb_target_group_arn
  ecs_cluster                 = var.ecs_cluster
  # app_port                    = var.app_port

}

# # creation of auto scaling group

module "ecs_asg" {
  source      = "./modules/asg"
  name_prefix = local.name_prefix
  environment = local.environment
  ecs_service = module.ecs.ecs_service
  ecs_cluster = module.ecs.ecs_cluster

}

# # # create route-53 record set

module "route-53" {
  source                             = "./modules/route-53"
  name_prefix                        = local.name_prefix
  environment                        = local.environment
  domain_name                        = module.ssl_certificate.domain_name
  record_name                        = var.record_name
  application_load_balancer_dns_name = module.application_load_balancer.application_load_balancer_dns_name
  application_load_balancer_zone_id  = module.application_load_balancer.application_load_balancer_zone_id

}

# print the website url
output "website_url" {
  value = join("", ["https://", var.record_name, ".", var.domain_name])
}
