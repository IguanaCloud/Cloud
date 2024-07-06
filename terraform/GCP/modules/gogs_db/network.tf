resource "google_compute_global_address" "gogs_private_ip_address" {
  name          = "gogs-db-peering"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = var.vpc_id
}

