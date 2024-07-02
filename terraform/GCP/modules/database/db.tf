resource "google_sql_database_instance" "postgres" {
  project             = var.project
  name                = "${var.env}-${var.region}-${var.app}-postgres"
  database_version    = "POSTGRES_13"
  region              = var.region
  deletion_protection = true  # Protection enabled for the first instance

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = var.db_instance_type
    disk_size = var.db_disk_size
    
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_id
    }
  }
}

resource "google_sql_database_instance" "goks_postgres" {
  project             = var.project
  name                = "${var.env}-${var.region}-${var.app}-goks-postgres"
  database_version    = "POSTGRES_13"
  region              = var.region
  deletion_protection = false  # Protection disabled for the second instance

  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = var.db_instance_type
    disk_size = var.db_disk_size
    
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_id
    }
  }
}

resource "google_sql_database" "database" {
  name     = "${var.app}-db"
  instance = google_sql_database_instance.postgres.name
}

resource "google_sql_database" "goks_db" {
  name     = "goks-db"
  instance = google_sql_database_instance.goks_postgres.name
}

resource "google_sql_user" "users" {
  name     = "${var.app}-user"
  instance = google_sql_database_instance.postgres.name
  password = random_password.db_user_pass.result
}

resource "google_sql_user" "goks_users" {
  name     = "${var.app}-goks-user"
  instance = google_sql_database_instance.goks_postgres.name
  password = random_password.goks_db_user_pass.result
}

resource "random_password" "db_user_pass" {
  length  = 16
  special = true
}

resource "random_password" "goks_db_user_pass" {
  length  = 16
  special = true
}