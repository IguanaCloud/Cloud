resource "google_compute_region_instance_group_manager" "geo" {
  name               = "${var.env}-${var.region}-${var.app}-geo-group-manager"
  base_instance_name = "${var.env}-${var.region}-${var.app}-webapp-application"
  region             = var.region

  version {
    instance_template = google_compute_instance_template.geo_template.id
    name              = "primary"
  }

  target_size = 1

  named_port {
    name = "http"
    port = 8080
  }

  auto_healing_policies {
    health_check      = google_compute_region_health_check.geo.id
    initial_delay_sec = 300
  }
}
