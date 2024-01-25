# route-53 variables

variable "name_prefix" {
  type    = string
  default = ""
}

variable "environment" {}

variable "domain_name" {}
variable "record_name" {}
variable "application_load_balancer_dns_name" {}
variable "application_load_balancer_zone_id" {}