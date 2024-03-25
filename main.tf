provider "google" {
  project = var.project_id
  region  = "europe-west1"
  zone    = "europe-west1-c"
}

// Modül çağrıları
module "vpc_subnet" {
  source             = "./vpc_subnet_module"
  project_id         = var.project_id
  suffix             = var.suffix
}

module "private_google_access" {
  source             = "./private_google_access_module"
  network_self_link = module.vpc_subnet.network_self_link
  suffix             = var.suffix
}

module "snapshot_policy" {
  source             = "./snapshot_policy_module"
  suffix             = var.suffix
}

module "compute_instance" {
  source                    = "./compute_instance_module"
  network_self_link         = module.vpc_subnet.network_self_link
  primary_subnet_self_link = module.vpc_subnet.primary_subnet_self_link
  suffix                    = var.suffix
  snapshot_policy_name    = module.snapshot_policy.name
}

module "firewall_rule" {
  source             = "./firewall_rule_module"
  network_self_link = module.vpc_subnet.network_self_link
  suffix             = var.suffix
}

// Variables
variable "project_id" {
  description = "Google Cloud project ID"
}

variable "suffix" {
  description = "Suffix to append to resource names"
}

variable "project_id" {
  description = "Google Cloud project ID"
}
