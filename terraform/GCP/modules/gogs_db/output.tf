output "database_private_ip" {
  value = google_sql_database_instance.gogs.ip_address[0].ip_address
}

output "database_pass" {
  value     = random_password.gogs_db_user_pass.result
  sensitive = true
}