locals {
  environment = "staging"
  domain_name = "nginx.${aws_route53_zone.this.name}"

  tags = {
    Environment = local.environment
    ManagedBy   = "terraform"
  }
}

module "vpc" {
  source = "../modules/vpc"

  name = "${local.environment}-nginx-sample"
  cidr = "10.10.0.0/16"

  azs             = ["ap-northeast-1a", "ap-northeast-1c"]
  public_subnets  = ["10.10.0.0/24", "10.10.1.0/24"]
  private_subnets = ["10.10.10.0/24", "10.10.11.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true # staging はコスト優先でNAT Gatewayを1つに集約

  tags = local.tags
}

module "acm_certificate" {
  source  = "terraform-aws-modules/acm/aws"
  version = "6.3.0"

  # 既にACMコンソールからワイルドカード証明書として発行済み(SANにapexを含む)のものをimportして管理する
  domain_name                        = "*.${aws_route53_zone.this.name}"
  subject_alternative_names          = [aws_route53_zone.this.name]
  dns_ttl                            = 300
  validation_allow_overwrite_records = false
  validation_method                  = "DNS"
  zone_id                            = aws_route53_zone.this.zone_id

  tags = local.tags
}

module "ecs_nginx" {
  source = "../modules/ecs_nginx"

  environment = local.environment
  aws_region  = var.aws_region

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnets
  private_subnet_ids = module.vpc.private_subnets

  certificate_arn = module.acm_certificate.acm_certificate_arn

  desired_count = 1
  cpu           = 256
  memory        = 512

  tags = local.tags
}

resource "aws_route53_record" "nginx" {
  zone_id = aws_route53_zone.this.zone_id
  name    = local.domain_name
  type    = "A"

  alias {
    name                   = module.ecs_nginx.lb_dns_name
    zone_id                = module.ecs_nginx.lb_zone_id
    evaluate_target_health = true
  }
}
