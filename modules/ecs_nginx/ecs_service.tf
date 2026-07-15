resource "aws_ecs_service" "nginx" {
  name            = "${var.environment}-nginx"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [aws_security_group.ecs_service.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.nginx.arn
    container_name   = "nginx"
    container_port   = var.container_port
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  # デプロイはCI/CDが行う想定のため、Terraform実行時にタスク定義の更新で上書きしない
  lifecycle {
    ignore_changes = [task_definition]
  }

  depends_on = [aws_lb_listener.http]

  tags = var.tags
}
