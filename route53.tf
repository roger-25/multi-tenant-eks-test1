# Automatically fetch the Route 53 hosted zone by domain name
data "aws_route53_zone" "primary" {
  name         = var.domain_name
}
