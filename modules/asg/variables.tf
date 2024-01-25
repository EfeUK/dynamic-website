# asg variables

variable "name_prefix" {
  type    = string
  default = ""
}

variable "environment" {}

variable "ecs_service" {}
variable "ecs_cluster" {}