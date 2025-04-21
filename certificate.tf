data "aws_acm_certificate" "issued" {
  domain   = var.domain_name   # e.g. "roger.devops-roger.publicvm.com"
  statuses = ["ISSUED"]
  most_recent = true
}
