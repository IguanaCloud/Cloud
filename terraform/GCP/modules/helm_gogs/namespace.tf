resource "kubernetes_namespace" "gitea" {
  metadata {
    name = "gogs-app"
  }
}

resource "google_compute_global_address" "ip_address" {
  name    = "gogs-ip"
  project = var.project
}
