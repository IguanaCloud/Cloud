resource "google_compute_instance_template" "geo_template" {
  project      = var.project
  name         = "${var.env}-${var.region}-${var.app}-template-geocitizen-webapp"
  machine_type = var.instance_type

  network_interface {
    network    = var.vpc_network
    subnetwork = var.sub_network
  }

  disk {
    source_image = var.image_type
    auto_delete  = true
    boot         = true
  }

  tags = ["allow-ssh", "load-balanced-backend"]

  metadata = {
    ssh-keys = "ubuntu:${file("C:/Users/anton/.ssh/id_rsa.pub")}"
  }
}