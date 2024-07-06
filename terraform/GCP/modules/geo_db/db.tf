resource "google_sql_database_instance" "geo" {

  name                = "${local.full_name}-geo"
  database_version    = "POSTGRES_15"
  deletion_protection = false

  settings {
    edition                     = "ENTERPRISE"
    tier                        = "db-custom-1-3840"
    availability_type           = "ZONAL"
    disk_size                   = 50
    disk_autoresize             = true
    deletion_protection_enabled = false

    backup_configuration {
      enabled                        = true
      point_in_time_recovery_enabled = true
      start_time                     = "01:00"
      transaction_log_retention_days = 7
    }
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_id
    }
    user_labels = {
      env = var.env
      app = var.app
    }
  }
}

resource "google_sql_database" "geo_db" {
  name     = "citizen-db"
  instance = google_sql_database_instance.geo.name
}

resource "google_sql_user" "geo_users" {
  name     = "citizen-user"
  instance = google_sql_database_instance.geo.name
  password = random_password.geo_db_user_pass.result
}