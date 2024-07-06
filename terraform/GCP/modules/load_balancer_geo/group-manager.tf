resource "google_compute_instance_group_manager" "geo" {

  name = "${local.full_name}-geocitizen-group-manager"
  version {
    instance_template = google_compute_instance_template.geo_template.id
    name              = "primary"
  }
  base_instance_name = "${local.full_name}-webapp-application"
  target_size        = 3

  named_port {
    name = "http"
    port = 8080
  }

}