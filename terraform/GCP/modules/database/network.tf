resource "google_compute_global_address" "private_ip_address" {
  project       = var.project
  name          = "db-peering-${var.env}-${var.region}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc_id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.vpc_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_compute_firewall" "allow_database" {
  project = var.project
  name    = "${var.env}-${var.region}-${var.app}-allow-database-traffic"
  network = var.vpc_network

  allow {
    protocol = "tcp"
    ports    = var.allowed_ports
  }

  source_ranges = [var.gke_subnet_cidr, var.vm_subnet_cidr]
}