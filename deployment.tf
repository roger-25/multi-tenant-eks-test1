resource "kubernetes_deployment_v1" "myapp1" {
  metadata {
    name      = "${var.tenant_name}-deployment"
    namespace = kubernetes_namespace.user_namespace.metadata[0].name
    labels = {
      app = "myapp1"
    }
  }

  spec 
    replicas = 1

    selector {
      match_labels = {
        app = "myapp1"
      }
    }

    template {
      metadata {
        labels = {
          app = "myapp1"
        }
      }

      spec {
        container {
          image = var.image_url
          name  = "app-container"
          port {
            container_port = 80
          }

          # Optional: Add health checks
          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }
          }
        }
      }
    }
  }

