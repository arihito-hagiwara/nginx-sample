import {
  to = aws_route53_zone.this
  id = "Z0867985ZBMEJH3PVJF4"
}

import {
  to = module.acm_certificate.aws_acm_certificate.this[0]
  id = "arn:aws:acm:ap-northeast-1:673222099354:certificate/99da4c16-639a-4f4a-a938-94f190e874e1"
}

import {
  to = module.acm_certificate.aws_route53_record.validation[0]
  id = "Z0867985ZBMEJH3PVJF4_c066c43ed0eb444d0117e630ac077016.st.safiesandbox.com._CNAME"
}
