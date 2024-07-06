resource "google_container_cluster" "primary" {
  name                     = "${local.full_name}-gogs-kubernetes"
  location                 = var.zone
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false
  network                  = var.vpc_id
  subnetwork               = var.subnet_id
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${local.full_name}-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = 3

  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    disk_size_gb = 20

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    labels = {
      env = var.env
      app = var.app
    }
  }
}

resource "null_resource" "update_kubeconfig" {
  depends_on = [google_container_cluster.primary]

  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --zone ${var.zone} --project ${var.project}"
  }
}