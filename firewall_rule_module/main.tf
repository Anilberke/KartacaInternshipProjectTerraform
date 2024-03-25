// firewall_rule_module/main.tf

variable "network_self_link" {}
variable "suffix" {}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-${var.suffix}"
  network = var.network_self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["kartaca-staj"]
}
