resource "kubernetes_namespace" "user_namespace" {
  metadata {
    name = "user-${terraform.workspace}"  # Or user-${var.tenant_name}
  }
}
