resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "bucket_tfstate" {
  name          = "${var.env}-${var.region}-${var.app}-tf-state-${random_id.bucket_prefix.hex}"
  project       = var.project
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      num_newer_versions = 30
    }
  }

  labels = {
    env = var.env
    app = var.app
  }
}