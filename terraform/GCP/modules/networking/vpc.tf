resource "google_compute_network" "gen_vpc_network" {
  name                            = "${local.full_name}-gen-vpc"
  delete_default_routes_on_create = false
  auto_create_subnetworks         = false
  routing_mode                    = "REGIONAL"
}

resource "google_compute_subnetwork" "geo_subnet" {
  name          = "${local.full_name}-geo-subnet"
  ip_cidr_range = "10.2.2.0/29"
  network       = google_compute_network.gen_vpc_network.self_link
}

resource "google_compute_subnetwork" "gogs_subnet" {
  name          = "${local.full_name}-gogs-subnet"
  ip_cidr_range = "10.3.3.0/24"
  network       = google_compute_network.gen_vpc_network.self_link
}

resource "google_compute_subnetwork" "proxy-subnet" {
  name          = "${local.full_name}-proxy-subnet"
  ip_cidr_range = "10.129.0.0/26"
  network       = google_compute_network.gen_vpc_network.id
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
}

resource "google_compute_firewall" "allow_lb_geo" {
  project = var.project
  name    = "${local.full_name}-allow-lb-geo-traffic"
  network = google_compute_network.gen_vpc_network.id

  allow {
    protocol = "tcp"
    ports    = ["443", "8080", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
}