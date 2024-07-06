output "gogs_db_pass" {
  description = "Password for gogs db"
  value       = module.gogs_db.database_pass
  sensitive   = true
}

output "geo_db_pass" {
  description = "Password for geo db"
  value       = module.geo_db.database_pass
  sensitive   = true
}

output "gogs_db_private_ip" {
  description = "IP of gogs db"
  value       = module.gogs_db.database_private_ip
}

output "geo_db__private_ip" {
  description = "IP of geo db"
  value       = module.geo_db.database_private_ip
}


