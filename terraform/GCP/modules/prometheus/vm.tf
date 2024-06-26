resource "google_compute_instance" "prometheus_instance" {
  project             = var.project
  name                = "${var.env}-${var.region}-${var.app}-prometheus"
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
    device_name = "${var.env}-${var.region}-${var.app}-disk-prometheus"
    source      = google_compute_disk.disk_prometheus.id
  }

  metadata_startup_script = file("${path.module}/prom_startup.sh")

  metadata = {
    ssh-keys = "${var.env}-${var.region}-${var.app}-prometheus:${tls_private_key.ssh_key_prometheus.public_key_openssh}"
  }

  labels = {
    env = var.env
    app = var.app
  }
}

resource "google_compute_address" "public_ip" {
  project = var.project
  name    = "${var.env}-${var.region}-${var.app}-prometheus-ip"
  region  = var.region
}