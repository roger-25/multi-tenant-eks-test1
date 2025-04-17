data "aws_acm_certificate" "issued" {
  domain   = "*.rogeralex.work.gd"  # Your wildcard or specific domain
  statuses = ["ISSUED"]
}

resource "kubernetes_ingress_v1" "myapp1_ingress" {
  metadata {
    name      = "${var.tenant_name}-ingress"
    namespace = kubernetes_namespace.user_namespace.metadata[0].name
  }
   
    annotations = {
      # ALB Core Settings
      "alb.ingress.kubernetes.io/scheme"          = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"     = "ip"
      "alb.ingress.kubernetes.io/healthcheck-path" = "/healthz"
      
      # HTTPS Configuration
      "alb.ingress.kubernetes.io/certificate-arn" = data.aws_acm_certificate.issued.arn
      "alb.ingress.kubernetes.io/ssl-policy"      = "ELBSecurityPolicy-TLS13-1-2-2021-06"
      "alb.ingress.kubernetes.io/listen-ports"    = jsonencode([{"HTTPS" = 443}, {"HTTP" = 80}])
      
      # Redirects (HTTP → HTTPS)
      "alb.ingress.kubernetes.io/actions.ssl-redirect" = jsonencode({
        Type = "redirect"
        RedirectConfig = {
          Protocol   = "HTTPS"
          Port       = "443"
          StatusCode = "HTTP_301"
        }
      })
      
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
      host = "rogeralex.work.gd"
      http {
        # HTTP → HTTPS Redirect
        path {
          path = "/*"
          backend {
            service {
              name = "ssl-redirect"
              port {
                name = "use-annotation"  # Special value for redirects
              }
            }
          }
        }
        
        # Main Application Route
        path {
          path = "/*"
          backend {
            service {
              name = kubernetes_service_v1.app_service.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
