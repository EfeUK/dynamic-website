# create an auto scaling group for the ecs service
resource "aws_appautoscaling_target" "ecs_asg" {
  max_capacity       = 4
  min_capacity       = 1
  # resource_id        = "service/${var.name_prefix}-${var.environment}-service"
  resource_id = "service/${var.ecs_cluster.name}/${var.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

  depends_on = [var.ecs_service]
}

# create scaling policy for the auto scaling group
resource "aws_appautoscaling_policy" "ecs_policy" {
  name               = "${var.name_prefix}-${var.environment}-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "service/${var.name_prefix}-${var.environment}-cluster/${var.name_prefix}-${var.environment}-service"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  
  target_tracking_scaling_policy_configuration {

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = 70
    scale_out_cooldown = 300
    scale_in_cooldown  = 300
    disable_scale_in   = false 
  }

  depends_on = [aws_appautoscaling_target.ecs_asg]
}