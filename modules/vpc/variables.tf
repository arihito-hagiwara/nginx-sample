variable "name" {
  description = "VPC名(terraform-aws-modules/vpc/awsのname)"
  type        = string
}

variable "cidr" {
  description = "VPCのCIDRブロック"
  type        = string
}

variable "azs" {
  description = "使用するAZ一覧"
  type        = list(string)
}

variable "public_subnets" {
  description = "public subnetのCIDR一覧(azsと同じ順序・数)"
  type        = list(string)
}

variable "private_subnets" {
  description = "private subnetのCIDR一覧(azsと同じ順序・数)"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "NAT Gatewayを作成するか"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "trueの場合NAT Gatewayを1つに集約する(検証環境向け・コスト優先)"
  type        = bool
  default     = false
}

variable "tags" {
  description = "共通タグ"
  type        = map(string)
  default     = {}
}
