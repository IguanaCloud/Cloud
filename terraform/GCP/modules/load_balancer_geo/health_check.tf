resource "google_compute_region_health_check" "geo" {
  name = "${local.full_name}-geocitizen-hc"
  http_health_check {
    port_specification = "USE_SERVING_PORT"
  }
}
