output "gen_vpc_id" {
  description = "General vpc network id for applications"
  value = google_compute_network.gen_vpc_network.id
}

output "geo_subnet_id" {
  description = "Subnetwork for geocitizen application"
  value = google_compute_subnetwork.geo_subnet.id
}

output "gogs_subnet_id" {
  description = "Subnetwork for gogs application"
  value = google_compute_subnetwork.gogs_subnet.id
}

