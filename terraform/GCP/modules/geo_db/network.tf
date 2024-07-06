resource "google_compute_global_address" "geo_private_ip_address" {
  name          = "geo-db-peering"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = var.vpc_id
}

resource "google_service_networking_connection" "geo_private_vpc_connection" {
  network                 = var.vpc_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.geo_private_ip_address.name]
}

