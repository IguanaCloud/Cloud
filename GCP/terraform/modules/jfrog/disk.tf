resource "google_compute_disk" "disk_jfrog" {
  project = var.project
  name    = "${var.env}-${var.region}-${var.app}-disk-jfrog"
  type    = "pd-ssd"
  zone    = var.zone
  size    = var.disk_size
  labels = {
    env = var.env
    app = var.app
  }
}

resource "google_compute_resource_policy" "daily_backup" {
  name    = "${var.env}-${var.region}-${var.app}-daily-backup"
  project = var.project
  region  = var.region
  
  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "04:00"
      }
    }
    retention_policy {
      max_retention_days    = 14
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }
  }
}

resource "google_compute_disk_resource_policy_attachment" "disk_attach" {
  name    = google_compute_resource_policy.daily_backup.name
  disk    = google_compute_disk.disk_jfrog.name
  project = var.project
  zone    = var.zone
}