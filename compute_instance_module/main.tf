variable "network_self_link" {

}
variable "primary_subnet_self_link" {}
variable "suffix" {

}
variable "snapshot_policy_name" {
    
}

resource "google_compute_instance" "instance" {
  count        = 2
  name         = "kartaca-staj${count.index + 1}-${var.suffix}"
  machine_type = "e2-medium"
  zone         = "europe-west1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 16
    }
  }

  tags         = ["kartaca-staj"]
  network_interface {
    network    = var.network_self_link
    subnetwork = var.primary_subnet_self_link
    access_config {
      // Static IP allocation
    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    # Example startup script
    echo "Hello, World!" > /var/www/html/index.html
  EOF

  attached_disk {
    source = "persistent-disk-0"
  }
}

output "instance_names" {
  value = [for instance in google_compute_instance.instance : instance.name]
}

output "instance_ips" {
  value = [for instance in google_compute_instance.instance : instance.network_interface[0].network_ip]
}
