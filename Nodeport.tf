resource "kubernetes_service_v1" "myapp1_service" {
  metadata {
    name      = "${var.tenant_name}-service"
    namespace = kubernetes_namespace.user_namespace.metadata[0].name
    labels = { app = "myapp1" }
    # No alb.* annotations here
  }

  spec {
    type = "NodePort"
    selector = { app = "myapp1" }
    port {
      name        = "http"
      port        = 80
      target_port = 80
    }
  }
}
