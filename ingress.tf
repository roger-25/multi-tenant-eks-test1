resource "kubernetes_ingress_v1" "myapp1_ingress" {
  metadata {
    name      = "${var.tenant_name}-ingress"
    namespace = kubernetes_namespace.user_namespace.metadata[0].name
    annotations = {
      # ALB Core Settings
      "alb.ingress.kubernetes.io/scheme"           = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"      = "ip"
      "alb.ingress.kubernetes.io/healthcheck-path" = "/"
      "alb.ingress.kubernetes.io/healthcheck-interval-seconds" = "30"
      "alb.ingress.kubernetes.io/healthcheck-timeout-seconds"  = "5"
      "alb.ingress.kubernetes.io/success-codes"               = "200"

      # HTTPS Configuration
      "alb.ingress.kubernetes.io/certificate-arn"  = data.aws_acm_certificate.issued.arn
      "alb.ingress.kubernetes.io/ssl-policy"       = "ELBSecurityPolicy-TLS13-1-2-2021-06"
      "alb.ingress.kubernetes.io/listen-ports"     = jsonencode([
        { "HTTPS" = 443 },
        { "HTTP"  = 80 }
      ])

      # Redirect HTTP → HTTPS (simplified)
      "alb.ingress.kubernetes.io/ssl-redirect"     = "443"

      # Security Headers
      "alb.ingress.kubernetes.io/response-headers" = jsonencode({
        "Strict-Transport-Security" = "max-age=63072000; includeSubdomains; preload"
        "X-Content-Type-Options"    = "nosniff"
      })

      # Route53 Integration
      "external-dns.alpha.kubernetes.io/hostname" = "rogeralex.work.gd"
    }
  }

  spec {
    ingress_class_name = "alb"
    rule {
      host = "*.rogeralex.work.gd"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service_v1.myapp1_service.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}