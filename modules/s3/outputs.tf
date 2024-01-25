# export the s3 bucket name
output "dynamic_bucket" {
  value = var.dynamic_website_bucket
}

# export the environment file name
output "dynamic_file" {
  value = var.dynamic_file
}