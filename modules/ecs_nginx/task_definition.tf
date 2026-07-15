resource "aws_ecs_task_definition" "nginx" {
  family                   = "${var.environment}-nginx"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.execution.arn

  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = var.container_image
      essential = true

      # bootstrap用の公式nginxイメージはデフォルトで80番待受けのため、起動時にlisten portを書き換える。
      # CI/CDが自前のイメージに置き換えたらこのcommandは不要になる想定。
      command = [
        "/bin/sh", "-c",
        "sed -i 's/80;/${var.container_port};/g' /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"
      ]

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.nginx.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "nginx"
        }
      }
    }
  ])

  # CI/CDが後からECRの新しいイメージへ更新する運用のため、Terraform側では変更を無視する
  lifecycle {
    ignore_changes = [container_definitions]
  }

  tags = var.tags
}
