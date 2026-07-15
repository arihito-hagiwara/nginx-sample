resource "aws_ecs_cluster" "this" {
  name = "${var.environment}-nginx"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = var.tags
}
