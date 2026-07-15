resource "aws_cloudwatch_log_group" "nginx" {
  name              = "/ecs/${var.environment}-nginx"
  retention_in_days = var.log_retention_in_days

  tags = var.tags
}
