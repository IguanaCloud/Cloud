resource "random_password" "db_password" {
  length  = 16
  special = true
}

resource "google_secret_manager_secret" "db_password" {
  count     = var.enable_secret_manager ? 1 : 0
  project   = var.project
  secret_id = "${var.env}-${var.region}-${var.app}-db_password"
  labels = {
    env      = var.env
    app      = var.app
    resource = "database"
  }
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "db_password_version" {
  count       = var.enable_secret_manager ? 1 : 0
  secret      = google_secret_manager_secret.db_password[0].id
  secret_data = random_password.db_password.result
}