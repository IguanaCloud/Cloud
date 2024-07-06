output "database_private_ip" {
  value = google_sql_database_instance.geo.ip_address[0].ip_address
}

output "database_pass" {
  value     = random_password.geo_db_user_pass.result
  sensitive = true
}