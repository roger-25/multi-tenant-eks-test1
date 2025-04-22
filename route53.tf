# Automatically fetch the Route 53 hosted zone by domain name
data "aws_route53_zone" "primary" {
  name         = var.domain_name
}

resource "aws_route53_record" "tenant_dns" {
  zone_id = var.route53_zone_id
  name    = "${var.tenant_name}.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = [aws_lb.tenant_alb.dns_name]  # ← Use this instead of var.alb_dns_name
}

