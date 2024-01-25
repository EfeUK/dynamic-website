# export the s3 bucket name
output "dynamic_bucket" {
  value = var.dynamic_website_bucket
}

# export the environment file name
output "dynaic_file" {
  value = var.dynamic_file
}