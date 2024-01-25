# create an s3 bucket 
resource "aws_s3_bucket" "dynamic_website_bucket" {
  bucket = "${var.name_prefix}-${var.dynamic_website_bucket}"

  lifecycle {
    create_before_destroy = false
  }
}

# upload the environment file from local computer into the s3 bucket
resource "aws_s3_object" "upload_dynamic_file" {
  bucket = aws_s3_bucket.dynamic_website_bucket.id
  key    = var.dynamic_file
  source = "./${var.dynamic_file}"
}