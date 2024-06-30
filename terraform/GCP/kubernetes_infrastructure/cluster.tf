data "google_secret_manager_secret_version" "master_ipv4_cidr_block" {
  secret  = "${var.env}-${var.region}-${var.app}-master-ipv4-cidr-block"
  version = "latest"
}

data "google_secret_manager_secret_version" "cluster_ipv4_cidr_block" {
  secret  = "${var.env}-${var.region}-${var.app}-cluster-ipv4-cidr-block"
  version = "latest"
}

data "google_secret_manager_secret_version" "services_ipv4_cidr_block" {
  secret  = "${var.env}-${var.region}-${var.app}-services-ipv4-cidr-block"
  version = "latest"
}

resource "google_container_cluster" "primary" {
  name                     = "${var.env}-${var.region}-${var.app}-gke"
  location                 = var.zone
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false
  network                  = var.vpc_network
  subnetwork               = var.sub_network

  node_config {
    service_account = "iguanaserviceacc@iguana-dev-env.iam.gserviceaccount.com"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = data.google_secret_manager_secret_version.master_ipv4_cidr_block.secret_data
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = data.google_secret_manager_secret_version.cluster_ipv4_cidr_block.secret_data
    services_ipv4_cidr_block = data.google_secret_manager_secret_version.services_ipv4_cidr_block.secret_data
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.env}-${var.region}-${var.app}-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

  node_config {
    service_account = "iguanaserviceacc@iguana-dev-env.iam.gserviceaccount.com"
    preemptible     = true
    machine_type    = "e2-medium"
    disk_size_gb    = var.gke_disk_size

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    labels = {
      env = var.env
      app = var.app
    }
  }
}