output "lb_dns_name" {
  value = module.ecs_nginx.lb_dns_name
}

output "ecr_repository_url" {
  value = module.ecs_nginx.ecr_repository_url
}
