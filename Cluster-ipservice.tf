resource "kubernetes_service_v1" "myapp1_service" {
  metadata {
    name      = "${var.tenant_name}-service"
    namespace = kubernetes_namespace.user_namespace.metadata[0].name
    labels = {
      app = "myapp1"
    }
  }

  spec {
    type = "LoadBalancer"  # Change this to "LoadBalancer" to expose via ALB

    selector = {
      app = "myapp1"  # Matches your Deployment's pod labels
    }

    port {
      port        = 80    # Service port
      target_port = 80    # Container port (should match your container's exposed port)
    }
  }
}
