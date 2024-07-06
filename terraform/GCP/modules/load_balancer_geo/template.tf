resource "google_compute_instance_template" "geo_template" {
  name         = "${local.full_name}-template-geocitizen-webapp"
  machine_type = "e2-medium"
  network_interface {
    network    = var.vpc_network
    subnetwork = var.geo_sub_network
  }
  disk {
    source_image ="projects/ubuntu-os-cloud/global/images/family/ubuntu-2004-lts"
    auto_delete  = true
    boot         = true
  }
  tags = ["allow-ssh", "load-balanced-backend"]
  metadata = {
    ssh-keys = "ubuntu:${data.google_secret_manager_secret_version.ssh_key.secret_data}"
  }
}

data "google_secret_manager_secret_version" "ssh_key" {
  secret = "rsa_pub"
}
