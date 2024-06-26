resource "google_sql_database_instance" "postgres" {
  project             = var.project
  name                = "${var.env}-${var.region}-${var.app}-postgres"
  database_version    = "POSTGRES_15"
  region              = var.region
  deletion_protection = false

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "allow-all"
        value = "0.0.0.0/0"
      }
    }
  }

  timeouts {
    create = "30m"
    delete = "30m"
  }
}

resource "google_sql_database" "database" {
  name     = "citizen-db"
  instance = google_sql_database_instance.postgres.name
}

resource "google_sql_user" "users" {
  name     = "citizen-user"
  instance = google_sql_database_instance.postgres.name
  password = random_password.db_user_pass.result
}

resource "random_password" "db_user_pass" {
  length  = 16
  special = true
}