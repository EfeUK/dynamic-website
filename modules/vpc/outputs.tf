# export the region
output "region" {
  value = var.aws_region
}

# export the project name
output "name_prefix" {
  value = var.name_prefix
}

# export the environment
output "environment" {
  value = var.environment
}

# export the vpc id
output "vpc_id" {
  value = aws_vpc.vpc.id
}

# export the internet gateway
output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway.id
}

# export the public subnet az1 id
output "public_subnet_az1_id" {
  value = aws_subnet.pub_1a.id
}

# export the public subnet az2 id
output "public_subnet_az2_id" {
  value = aws_subnet.pub_1b.id
}

# export the private app subnet az1 id
output "private_app_subnet_az1_id" {
  value = aws_subnet.prvt_1a.id
}

# export the private app subnet az2 id
output "private_app_subnet_az2_id" {
  value = aws_subnet.prvt_1b.id
}

# export the private data subnet az1 id
output "private_data_subnet_az1_id" {
  value = aws_subnet.database_subnet_1a.id
}

# export the private data subnet az2 id
output "private_data_subnet_az2_id" {
  value = aws_subnet.database_subnet_1b.id
}

# export the first availability zone
output "availability_zone_1" {
  value = data.aws_availability_zones.available_zones.names[0]
}

# export the second availability zone
output "availability_zone_2" {
  value = data.aws_availability_zones.available_zones.names[1]
}
