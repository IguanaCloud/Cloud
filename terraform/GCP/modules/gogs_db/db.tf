resource "google_sql_database_instance" "gogs" {

  name                = "${local.full_name}-gogs"
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

resource "google_sql_database" "gogs_db" {
  name     = "citizen-db"
  instance = google_sql_database_instance.gogs.name
}

resource "google_sql_user" "gogs_users" {
  name     = "citizen-user"
  instance = google_sql_database_instance.gogs.name
  password = random_password.gogs_db_user_pass.result
}