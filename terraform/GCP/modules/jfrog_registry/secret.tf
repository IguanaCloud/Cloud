resource "tls_private_key" "ssh_key_jfrog_artifactory" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "google_secret_manager_secret" "ssh_key_jfrog_artifactory" {
  count     = var.enable_secret_manager ? 1 : 0
  project   = var.project
  secret_id = "${var.env}-${var.region}-${var.app}-ssh_jfrog_artifactory"
  labels = {
    env      = var.env
    app      = var.app
    resource = "jfrog_artifactory"
  }
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "ssh_key_jfrog_artifactory_version" {
  count       = var.enable_secret_manager ? 1 : 0
  secret      = google_secret_manager_secret.ssh_key_jfrog_artifactory[0].id
  secret_data = tls_private_key.ssh_key_jfrog_artifactory.private_key_openssh
}