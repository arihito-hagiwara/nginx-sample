resource "aws_route53_zone" "this" {
  name = "safiesandbox.com"

  tags = local.tags
}
