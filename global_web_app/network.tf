# Provider: GCP
provider "google" {
  project = var.project
  region  = var.gcp_region
}

# Data, Secret Manager Secret, provides image os to use on instance
# data "google_secret_manager_secret_version" "ami" {
#     secret = "ami"
# }

data "google_compute_zones" "available" {
  region = var.gcp_region
}

# Resources
#   VPC
resource "google_compute_network" "vpc-network" {
  name                    = "vpc-pluralsight"
  auto_create_subnetworks = var.vpc-auto-create-subnets
}

#   Subnet
resource "google_compute_subnetwork" "vpc-subnetwork" {
  name          = "nginx-subnet"
  ip_cidr_range = var.vpc-subnet-cidr-block[0]
  network       = google_compute_network.vpc-network.id
}

resource "google_compute_subnetwork" "vpc-subnetwork2" {
  name          = "nginx-subnet2"
  ip_cidr_range = var.vpc-subnet-cidr-block[1]
  network       = google_compute_network.vpc-network.id
}

#   Firewall CIDR 0.0.0.0/0, TCP: 80
resource "google_compute_firewall" "fw-allow-web-server" {
  name      = "web-server"
  network   = google_compute_network.vpc-network.id
  direction = "INGRESS"

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}

resource "google_compute_firewall" "allow-ssh-for-iap" {
  name    = "fw-allow-ssh-for-ip"
  network = google_compute_network.vpc-network.id

  source_ranges = ["35.235.240.0/20"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}