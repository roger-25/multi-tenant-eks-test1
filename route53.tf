resource "aws_route53_record" "tenant_dns" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "${var.tenant_name}.${var.domain_name}"  
  type    = "A"

  alias {
    name                   = aws_lb.ingress_alb.dns_name
    zone_id                = aws_lb.ingress_alb.zone_id
    evaluate_target_health = true
  }
}
