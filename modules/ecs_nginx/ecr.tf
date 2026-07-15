resource "aws_ecr_repository" "nginx" {
  name                 = "${var.environment}-nginx"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}
