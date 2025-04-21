resource "aws_route53_record" "tenant_dns" {
  zone_id = var.alb_zone_id
  name    = "${var.tenant_name}.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = [var.alb_dns_name]
}


data "aws_route53_zone" "primary" {
  name         = var.domain_name
  private_zone = false
}
