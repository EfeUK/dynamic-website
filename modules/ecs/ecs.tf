# create ecs cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.name_prefix}-${var.environment}-cluster"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

# create cloudwatch log group
resource "aws_cloudwatch_log_group" "log_group" {
  name = "/ecs/${var.name_prefix}-${var.environment}-td"

  lifecycle {
    create_before_destroy = true
  }
}

# create task definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "${var.name_prefix}-${var.environment}-td"
  execution_role_arn       = var.ecs_task_execution_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 2048
  memory                   = 4096

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = var.architecture
  }

  # create container definition
  container_definitions = jsonencode([
    {
      name      = "${var.name_prefix}-${var.environment}-container"
      image     = "${var.container_image}"
      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]

      # environmentFiles = [
      #   {
      #     value = "arn:aws:s3:::${var.name_prefix}-${var.dynamic_website_bucket}/${var.dynamic_file}"
      #     type  = "s3"
      #   }
      # ]

      # logConfiguration = {
      #   logDriver = "awslogs",
      #   options = {
      #     # "awslogs-group"         = "${aws_cloudwatch_log_group.log_group}",
      #     "awslogs-region"        = "${var.aws_region}",
      #     "awslogs-stream-prefix" = "ecs"
      #   }
      # }
    }
  ])
}

# create ecs service
resource "aws_ecs_service" "ecs_service" {
  name                               = "${var.name_prefix}-${var.environment}-service"
  launch_type                        = "FARGATE"
  cluster                            = aws_ecs_cluster.ecs_cluster.id
  task_definition                    = aws_ecs_task_definition.ecs_task_definition.arn
  platform_version                   = "LATEST"
  desired_count                      = 2
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  # task tagging configuration
  enable_ecs_managed_tags = false
  propagate_tags          = "SERVICE"

  # vpc and security groups
  network_configuration {
    subnets          = [var.private_app_subnet_az1_id, var.private_app_subnet_az2_id]
    security_groups  = [var.ecs_security_group_id]
    assign_public_ip = false
  }

  # load balancing
  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "${var.name_prefix}-${var.environment}-container"
    container_port   = 80
  }
}