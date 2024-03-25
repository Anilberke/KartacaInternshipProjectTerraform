variable "suffix" {}

resource "google_compute_snapshot_schedule" "autosnap" {
  name             = "autosnap-${var.suffix}"
  description      = "Snapshot policy for Compute Engine disks"
  region           = "europe-west1"
  schedule_start   = "03:00"
  schedule_end     = "04:00"
  daily_schedule   = true
  snapshot_properties {
    location = "EU"
    storage_locations = ["EU"]
  }
  snapshot_properties_retention_policy {
    max_retention_days    = 7
    on_source_disk_delete = "DELETE"
  }
}