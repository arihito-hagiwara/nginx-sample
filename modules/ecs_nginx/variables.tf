variable "environment" {
  description = "環境名(staging, production等)。リソース名のprefixに使う"
  type        = string
}

variable "aws_region" {
  description = "デプロイ先リージョン(CloudWatch Logsの設定に使用)"
  type        = string
}

variable "vpc_id" {
  description = "ALB/ECS SGを作成するVPCのID"
  type        = string
}

variable "public_subnet_ids" {
  description = "ALBを配置するpublic subnetのID一覧"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "ECSタスクを配置するprivate subnetのID一覧"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "ALBへのHTTP/HTTPSアクセスを許可するCIDR一覧"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "certificate_arn" {
  description = "ALBのHTTPSリスナーに使うACM証明書のARN"
  type        = string
}

variable "container_image" {
  description = "初回起動用のnginxイメージ。以降はCI/CDがECRへpushしたイメージで更新する想定(container_definitionsの変更はTerraformで無視する)"
  type        = string
  default     = "public.ecr.aws/nginx/nginx:1.27"
}

variable "container_port" {
  description = "nginxコンテナが待ち受けるポート(ALB→ECSタスク間。ALBの公開リスナーは80のまま)"
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "ALBヘルスチェックのパス"
  type        = string
  default     = "/"
}

variable "desired_count" {
  description = "ECS Serviceのタスク数"
  type        = number
}

variable "cpu" {
  description = "Fargateタスクに割り当てるvCPU(単位: 1/1024 vCPU)"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Fargateタスクに割り当てるメモリ(MiB)"
  type        = number
  default     = 512
}

variable "log_retention_in_days" {
  description = "CloudWatch Logsの保持日数"
  type        = number
  default     = 14
}

variable "tags" {
  description = "共通タグ"
  type        = map(string)
  default     = {}
}
