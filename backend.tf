# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "store-tf-state"
    key            = "dynamic-website/terraform.tfstate"
    region         = "eu-west-1"
    profile        = "efeuk"
    dynamodb_table = "tf-state-lock"
  }
}