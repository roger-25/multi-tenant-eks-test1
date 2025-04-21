data "aws_acm_certificate" "issued" {
  domain   = "*.rogeralex.work.gd"
  statuses = ["ISSUED"]

  lifecycle {
    postcondition {
      condition     = self.arn != null
      error_message = "ACM certificate for '${self.domain}' not found. Verify it exists in us-east-1 and is ISSUED."
    }
  }
}