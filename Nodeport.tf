resource "kubernetes_service_v1" "myapp1_service" {
  metadata {
    name      = "${var.tenant_name}-service"
    namespace = kubernetes_namespace.user_namespace.metadata[0].name
    labels = {
      app = "myapp1"
    }
    annotations = {
      # Required for AWS ALB health check path
      "alb.ingress.kubernetes.io/healthcheck-path" = "/health-check"
    }
  }

  spec {
    type = "LoadBalancer"  # Change to LoadBalancer to create a new LB for each service

    selector = {
      app = "myapp1"  # Matches your Deployment
    }

    port {
      name        = "http"
      port        = 80         # Exposed port for clients (used in Ingress)
      target_port = 80         # Port on container
    }
  }
}