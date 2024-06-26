resource "google_compute_disk" "disk_jenkins" {
  project = var.project
  name    = "${var.env}-${var.region}-${var.app}-disk-jenkins"
  type    = "pd-ssd"
  zone    = var.zone
  size    = var.disk_size
  labels = {
    env = var.env
    app = var.app
  }
}