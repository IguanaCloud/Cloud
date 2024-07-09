resource "kubernetes_namespace" "gitea" {
  metadata {
    name = "gogs-app"
  }
}