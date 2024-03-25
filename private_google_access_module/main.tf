variable "network_self_link" {}
variable "suffix" {}

resource "google_compute_global_address" "private_google_access" {
  name          = "private-google-access-${var.suffix}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.network_self_link
}