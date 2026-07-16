output "lb_dns_name" {
  value = aws_lb.nginx.dns_name
}

output "lb_arn" {
  value = aws_lb.nginx.arn
}

output "lb_zone_id" {
  description = "Route53 ALIASレコードの作成に使うALBのHosted Zone ID"
  value       = aws_lb.nginx.zone_id
}

output "target_group_arn" {
  value = aws_lb_target_group.nginx.arn
}

output "ecr_repository_url" {
  value = aws_ecr_repository.nginx.repository_url
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "ecs_service_name" {
  value = aws_ecs_service.nginx.name
}
