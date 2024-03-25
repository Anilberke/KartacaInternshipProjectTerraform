variable "project_id" {}
variable "suffix" {}

resource "google_compute_network" "my_network" {
  name = "my-network-${var.suffix}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "primary_subnet" {
  name          = "primary-subnet-${var.suffix}"
  network       = google_compute_network.my_network.self_link
  region        = "europe-west1"
  ip_cidr_range = "10.100.0.0/23"
  
}

resource "google_compute_subnetwork" "gke_pod_subnet" {
  name          = "gke-pod-subnet-${var.suffix}"
  network       = google_compute_network.my_network.self_link
  region        = "europe-west1"
  ip_cidr_range = "10.100.2.0/18"
}

resource "google_compute_subnetwork" "gke_service_subnet" {
  name          = "gke-service-subnet-${var.suffix}"
  network       = google_compute_network.my_network.self_link
  region        = "europe-west1"
  ip_cidr_range = "10.100.64.0/20"
}

output "network_self_link" {
  value = google_compute_network.my_network.self_link
}

output "primary_subnet_self_link" {
  value = google_compute_subnetwork.primary_subnet.self_link
}

output "gke_pod_subnet_self_link" {
  value = google_compute_subnetwork.gke_pod_subnet.self_link
}

output "gke_service_subnet_self_link" {
  value = google_compute_subnetwork.gke_service_subnet.self_link
}