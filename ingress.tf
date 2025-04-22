resource "kubernetes_ingress_v1" "myapp1_ingress" {
  metadata {
    name      = "${var.tenant_name}-ingress"
    namespace = kubernetes_namespace.user_namespace.metadata[0].name

    annotations = {
      "kubernetes.io/ingress.class"                          = "alb"
      "alb.ingress.kubernetes.io/scheme"                     = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"                = "ip"
      "alb.ingress.kubernetes.io/healthcheck-path"           = "/health-check"
      "alb.ingress.kubernetes.io/certificate-arn"            = var.acm_certificate_arn
      "alb.ingress.kubernetes.io/ssl-policy"                 = "ELBSecurityPolicy-TLS13-1-2-2021-06"
      "alb.ingress.kubernetes.io/listen-ports"               = jsonencode([
        { "HTTPS" = 443 },
        { "HTTP"  = 80 }
      ])
      "alb.ingress.kubernetes.io/ssl-redirect"               = "443"
      "external-dns.alpha.kubernetes.io/hostname"            = "${var.tenant_name}.${var.domain_name}"
    }
  }

  spec {
    ingress_class_name = "alb"

    rule {
      host = "${var.tenant_name}.${var.domain_name}"
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
