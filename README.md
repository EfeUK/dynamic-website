# dynamic-website For any Microservice
Dynamic Website Project


# Dynamic Website Hosting on AWS using ECS, Docker, Flask, and Terraform

## Overview

This project demonstrates how to deploy a dynamic website using Amazon ECS (Elastic Container Service), Docker, Flask (a Python web framework), and Terraform. The infrastructure includes an ECS cluster, VPC, security groups, Route 53 for domain management, NAT gateway for internet access, Application Load Balancer (ALB), IAM role, and more.

## Components

- **ECS (Elastic Container Service):** Used to manage and orchestrate Docker containers hosting the Flask application.

- **Docker:** Containerization technology used to package the Flask application, ensuring consistency across different environments.

- **Flask App:** A simple Python web application that dynamically displays a string based on user input, in this use case.

- **VPC (Virtual Private Cloud):** Provides isolated network infrastructure for the ECS cluster.

- **Security Groups:** Controls inbound and outbound traffic to the ECS instances.

- **Route 53:** Manages domain names and directs traffic to the Application Load Balancer.

- **NAT Gateway:** Enables ECS instances in private subnets to access the internet.

- **ALB (Application Load Balancer):** Distributes incoming application traffic across multiple ECS instances.

- **IAM Role:** Grants necessary permissions to ECS instances.

- **Terraform:** Infrastructure as Code tool used to provision and manage AWS resources.

## Usage

### Prerequisites

- Install [Terraform](https://www.terraform.io/downloads.html) on your local machine.
- AWS CLI configured with necessary access keys.

### Setup

1. Clone this repository:

   ```bash
   git clone https://github.com/EfeUK/dynamic-website.git
   cd your-dynamic-website


2. Create a terraform.tfvars file in the project root:
   
   ```
   # terraform.tfvars

   aws_access_key = "your-aws-access-key"
   aws_secret_key = "your-aws-secret-key"
   aws_region     = "your-aws-region"
   # ... add other variables as needed


3. Create a terraform.tfvars file in the project root:
   
   ```
   Initialize Terraform and apply the configuration:
   terraform init
   terraform apply


4. Clean Up
   To avoid unnecessary charges, you can destroy the infrastructure when you're done:
   terraform destroy


Additional Notes
The terraform.tfvars file is intentionally left out in this repository for security reasons. Users should create their own file with appropriate values.
Ensure that your AWS account has the necessary permissions for creating the specified resources.
This project is for educational purposes and may not be suitable for production use without further customization and security considerations.

   