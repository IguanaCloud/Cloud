provider "google" {
  credentials = file("credentials.json")
  project     = "cryptic-album-424009-a2"
  region      = "us-central1"
  zone        = "us-central1-c"
}

# Створення нової мережі
resource "google_compute_network" "vpc_network" {
  name                    = "my-vpc-network"
  auto_create_subnetworks = "true"
}

# Правило брандмауера для дозволу SSH трафіку
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Створення інстансу з використанням нової мережі
resource "google_compute_instance" "ubuntu_instance" {
  name         = "ubuntu-instance"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20240519"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.self_link

    access_config {
      // Ephemeral public IP
    }
  }

  tags = ["web", "dev"]

  metadata_startup_script = <<-EOT
    #! /bin/bash
    sudo apt-get update
    sudo apt-get -y upgrade

    # Встановлення Terraform
    sudo apt-get install -y wget unzip
    wget https://releases.hashicorp.com/terraform/1.5.1/terraform_1.5.1_linux_amd64.zip
    unzip terraform_1.5.1_linux_amd64.zip
    sudo mv terraform /usr/local/bin/
    terraform --version
  EOT
}

output "instance_ip" {
  value = google_compute_instance.ubuntu_instance.network_interface[0].access_config[0].nat_ip
}

