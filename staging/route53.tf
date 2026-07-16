resource "aws_route53_zone" "this" {
  name = "st.safiesandbox.com"

  tags = local.tags
}
