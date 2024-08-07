resource "random_password" "geo_db_user_pass" {
  length           = 16
  special          = true
  override_special = "!#$%*()-_=+[]{}:?"
}

resource "google_secret_manager_secret" "database_credentials" {
  secret_id = "${var.env}-${var.region}-${var.app}-cred-geo"

  labels = {
    env      = var.env
    app      = var.app
    resource = "db"
  }

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "db_password_version" {
  secret      = google_secret_manager_secret.database_credentials.id
  secret_data = random_password.geo_db_user_pass.result
}