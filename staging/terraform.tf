terraform {
  required_version = ">= 1.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # NOTE: 現状はlocal backendで動作確認中。運用開始時にS3 backendへ切り替える
  # backend "s3" {
  #   bucket = "xxxxx-terraform-state"
  #   key    = "nginx-sample/staging/terraform.tfstate"
  #   region = "ap-northeast-1"
  # }
}

provider "aws" {
  region = var.aws_region
}
