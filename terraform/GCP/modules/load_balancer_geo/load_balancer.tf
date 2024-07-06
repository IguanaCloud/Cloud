resource "google_compute_forwarding_rule" "geo" {
  name                  = "${local.full_name}-geocitizen-forwarding-rule"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "443"
  target                = google_compute_region_target_https_proxy.geo.id
  network               = var.vpc_network
  ip_address            = google_compute_address.load_balancer.address
  network_tier          = "STANDARD"
}

resource "google_compute_region_target_https_proxy" "geo" {
  name             = "${local.full_name}-geocitizen-proxy"
  url_map          = google_compute_region_url_map.geo.id
  ssl_certificates = [google_compute_region_ssl_certificate.iguana.id]
}

resource "google_compute_region_url_map" "geo" {
  name            = "${local.full_name}-geocitizen-map"
  default_service = google_compute_region_backend_service.geo.id
}

resource "google_compute_address" "load_balancer" {
  name         = "${local.full_name}-geocitizen-ip-1"
  network_tier = "STANDARD"
}

resource "google_compute_region_ssl_certificate" "iguana" {
  name        = "${local.full_name}-ssl-certificate-for-iguana"
  private_key = data.google_secret_manager_secret_version.private_key.secret_data
  certificate = data.google_secret_manager_secret_version.certificate.secret_data
}

data "google_secret_manager_secret_version" "private_key" {
  secret = "privkey"
}

data "google_secret_manager_secret_version" "certificate" {
  secret = "fullchain"
}