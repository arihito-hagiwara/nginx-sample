output "lb_dns_name" {
  value = module.ecs_nginx.lb_dns_name
}

output "domain_name" {
  value = local.domain_name
}

output "ecr_repository_url" {
  value = module.ecs_nginx.ecr_repository_url
}

output "route53_zone_id" {
  value = aws_route53_zone.this.zone_id
}

output "route53_name_servers" {
  value = aws_route53_zone.this.name_servers
}
