resource "google_compute_router" "router_database" {
  project = var.project
  name    = "${var.env}-${var.region}-${var.app}-database-router"
  region  = var.region
  network = var.vpc_network

  bgp {
    asn = 64514
  }
}

resource "google_compute_subnetwork" "database_sub_network" {
  project       = var.project
  name          = "${var.env}-${var.region}-${var.app}-subnet-database"
  ip_cidr_range = var.subnet_cidr_range
  network       = var.vpc_network
  region        = var.region
}

resource "google_compute_firewall" "allow_database" {
  project = var.project
  name    = "${var.env}-${var.region}-${var.app}-allow-database-traffic"
  network = var.vpc_network

  allow {
    protocol = "tcp"
    ports    = var.allowed_ports
  }

  source_ranges = var.allowed_source_ranges
}

resource "google_compute_global_address" "private_ip_address" {
  count         = var.create_private_ip_address ? 1 : 0
  project       = var.project
  name          = "db-peering-${var.env}-${var.region}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc_id
}