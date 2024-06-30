resource "google_compute_router" "router_lb_geo" {
  project = var.project
  name    = "${var.env}-${var.region}-${var.app}-lb-geo-router"
  region  = var.region
  network = var.vpc_network
}

resource "google_compute_subnetwork" "lb_geo_sub_network" {
  project       = var.project
  name          = "${var.env}-${var.region}-${var.app}-subnet-lb-geo"
  ip_cidr_range = var.subnet_cidr_range
  region        = var.region
  network       = var.vpc_network
}

resource "google_compute_firewall" "allow_lb_geo" {
  project = var.project
  name    = "${var.env}-${var.region}-${var.app}-allow-lb-geo-traffic"
  network = var.vpc_network

  allow {
    protocol = "tcp"
    ports    = var.allowed_ports
  }

  source_ranges = var.allowed_source_ranges
}