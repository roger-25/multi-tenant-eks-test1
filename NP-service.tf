resource "kubernetes_service_v1" "myapp1_service" {
  metadata {
    name      = "${var.tenant_name}-service"
    namespace = kubernetes_namespace.user_namespace.metadata[0].name
  }
  spec {
    type = "ClusterIP"  # Suitable for Ingress
    selector = {
      app = "myapp1"  # Matches your Deployment's pod labels
    }
    port {
      name        = "http"
      port        = 80    # Service port
      target_port = 80    # Container port (updated to match pod)
      protocol    = "TCP"
    }
  }
}