locals {
  environment = "staging"

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

module "ecs_nginx" {
  source = "../modules/ecs_nginx"

  environment = local.environment
  aws_region  = var.aws_region

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnets
  private_subnet_ids = module.vpc.private_subnets

  desired_count = 1
  cpu           = 256
  memory        = 512

  tags = local.tags
}
