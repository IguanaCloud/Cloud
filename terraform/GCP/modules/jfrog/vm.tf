resource "google_compute_instance" "jfrog_instance" {
  project             = var.project
  name                = "${var.env}-${var.region}-${var.app}-jfrog"
  machine_type        = var.instance_type
  zone                = var.zone
  deletion_protection = var.deletion_protection

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = var.vpc_network
    subnetwork = "projects/${var.project}/regions/${var.region}/subnetworks/${var.sub_network}"
    access_config {
      nat_ip = google_compute_address.public_ip.address
    }
  }

  attached_disk {
    device_name = "${var.env}-${var.region}-${var.app}-disk-jfrog"
    source      = google_compute_disk.disk_jfrog.id
  }

  metadata_startup_script = file("${path.module}/jfrog_startup.sh")

  metadata = {
    ssh-keys = "${var.env}-${var.region}-${var.app}-jfrog:${tls_private_key.ssh_key_jfrog.public_key_openssh}"
  }

  labels = {
    env = var.env
    app = var.app
  }
}

resource "google_compute_address" "public_ip" {
  project = var.project
  name    = "${var.env}-${var.region}-${var.app}-jfrog-ip"
  region  = var.region
}