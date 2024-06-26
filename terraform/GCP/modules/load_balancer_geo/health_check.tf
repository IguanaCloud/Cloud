resource "google_compute_region_health_check" "geo" {
  project             = var.project
  name                = "${var.env}-${var.region}-${var.app}-geocitizen-health-check"
  region              = var.region
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10

  http_health_check {
    port = 8080
  }

  lifecycle {
    ignore_changes = [name]
  }
}