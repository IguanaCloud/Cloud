resource "google_compute_region_backend_service" "geo" {
  project               = var.project
  name                  = "${var.env}-${var.region}-${var.app}-geocitizen-backend-service"
  region                = var.region
  load_balancing_scheme = "INTERNAL_MANAGED"
  protocol              = "HTTP"
  timeout_sec           = 10
  health_checks         = [google_compute_region_health_check.geo.id]

  backend {
    group           = google_compute_instance_group_manager.geo.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}