resource "kubernetes_namespace" "tenant_namespace" {
  metadata {
    name = "user-${terraform.workspace}"  # Or user-${var.tenant_name}
    labels = {
      created-by = "terraform"
    }
  }
}
