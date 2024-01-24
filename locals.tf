locals {
  application_name = "dynamic"
  name_prefix      = "dynamic-website"
  aws_region       = "eu-west-1"
  environment      = var.environment
  common_tags = {
    Terraform   = "true"
    InfraGroup  = local.name_prefix
    Application = "dynamic-project"
  }

}