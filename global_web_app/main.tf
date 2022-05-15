# Provider: GCP
provider "google" {
  project = "my-project-id"
  region  = "us-central1"
  zone    = "us-central1-c"
}

# Data, Secret Manager Secret, provides image os to use on instance
# data "google_secret_manager_secret_version" "ami" {
#     secret = "ami"
# }

# Resources
#   VPC
resource "google_compute_network" "vpc-network" {
  name                    = "vpc-pluralsight"
  auto_create_subnetworks = false
}

#   Subnet
resource "google_compute_subnetwork" "vpc-subnetwork" {
  name          = "nginx-subnet"
  ip_cidr_range = "10.0.0.0/24"
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

#   Compute Engine - f1.micro
resource "google_compute_instance" "web-server-instance" {
  name         = "nginx-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.vpc-network.id
    subnetwork = google_compute_subnetwork.vpc-subnetwork.id

    access_config {

    }
  }

  metadata_startup_script = <<SCRIPT
    sudo apt-get update
    sudo apt-get install -y nginx
    sudo rm /var/www/html/index.nginx-debian.html
    echo '<html><head><title>Taco Team Server</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">You did it! Have a &#127790;</span></span></p></body></html>' | sudo tee /var/www/html/index.html
    SCRIPT
}