resource "kubernetes_service_v1" "myapp1_service" {
  metadata {
    name = "${var.tenant_name}-service"
    namespace = kubernetes_namespace.user_namespace.metadata[0].name
  }

  spec {
    type = "ClusterIP"  # Internal-only service
    
    selector = {
      app = "myapp1"  # Must match your Deployment's pod labels
    }

    port {
      name        = "http"
      port        = 80       # Service port
      target_port = 8080     # Your container port
      protocol    = "TCP"
    }
    
    # Optional: Add health check endpoint
    port {
      name        = "health"
      port        = 8081
      target_port = 8081
      protocol    = "TCP"
    }
  }
}