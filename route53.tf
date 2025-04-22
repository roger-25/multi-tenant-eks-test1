# Automatically fetch the Route 53 hosted zone by domain name
data "aws_route53_zone" "primary" {
  name         = var.domain_name
}

# Create a new CNAME record for the tenant
resource "aws_route53_record" "tenant_dns" {
  zone_id = data.aws_route53_zone.primary.zone_id

  name    = "${var.tenant_name}.${var.domain_name}"  # e.g., roger.devops-roger.publicvm.com
  type    = "CNAME"
  ttl     = 300

  records = [var.alb_dns_name]
}
