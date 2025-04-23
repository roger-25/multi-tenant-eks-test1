resource "aws_route53_record" "tenant_alb_record" {
  zone_id = var.route53_zone_id
  name    = "${var.tenant_name}.${var.domain_name}"  # e.g., tenant1.example.com
  type    = "A"

  alias {
    name                   = aws_lb.tenant_alb.dns_name
    zone_id                = aws_lb.tenant_alb.zone_id
    evaluate_target_health = true
  }
}
