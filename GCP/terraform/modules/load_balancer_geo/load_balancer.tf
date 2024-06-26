resource "google_compute_subnetwork" "proxy_subnet" {
  name          = "${var.env}-${var.region}-${var.app}-proxy-subnet"
  ip_cidr_range = "10.0.1.0/24"  # Changed to avoid conflict
  region        = var.region
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
  network       = var.vpc_network
  project       = var.project
}

resource "google_compute_forwarding_rule" "geo" {
  project               = var.project
  name                  = "${var.env}-${var.region}-${var.app}-geocitizen-forwarding-rule"
  region                = var.region
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL_MANAGED"
  port_range            = "80"
  target                = google_compute_region_target_http_proxy.geo.id
  network               = var.vpc_network
  subnetwork            = var.sub_network
  ip_address            = google_compute_address.load_balancer.address
  depends_on            = [google_compute_subnetwork.proxy_subnet]
}

resource "google_compute_region_target_http_proxy" "geo" {
  project = var.project
  name    = "${var.env}-${var.region}-${var.app}-geocitizen-proxy"
  url_map = google_compute_region_url_map.geo.id
  region  = var.region
}

resource "google_compute_region_url_map" "geo" {
  project         = var.project
  name            = "${var.env}-${var.region}-${var.app}-geocitizen-map"
  region          = var.region
  default_service = google_compute_region_backend_service.geo.id
}

resource "google_compute_address" "load_balancer" {
  project      = var.project
  name         = "${var.env}-${var.region}-${var.app}-geocitizen-ip-1"
  address_type = "INTERNAL"
  region       = var.region
  subnetwork   = var.sub_network
}