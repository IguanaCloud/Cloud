resource "google_compute_region_health_check" "geo" {
  name = "${var.env}-${var.region}-${var.app}-geo-hc"
  http_health_check {
    port_specification = "USE_SERVING_PORT"
  }
}