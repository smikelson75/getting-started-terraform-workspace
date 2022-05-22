#   Compute Engine - f1.micro
resource "google_compute_instance" "web-server-instance" {
  name         = "nginx-instance"
  machine_type = var.instance-machine-type
  labels       = local.common_tags

  zone = data.google_compute_zones.available.names[2]

  boot_disk {
    initialize_params {
      image  = "debian-cloud/debian-11"
      labels = local.common_tags
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
    echo '<html><head><title>Taco Team Server</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">You did it! Have a &#127790;</span></span></p><p>'$(curl http://metadata.google.internal/computeMetadata/v1/instance/hostname -H Metadata-Flavor:Google | cut -d . -f1)'</p></body></html>' | sudo tee /var/www/html/index.html
    SCRIPT
}

#   Compute Engine - f1.micro
resource "google_compute_instance" "web-server-instance2" {
  name         = "nginx-instance2"
  machine_type = var.instance-machine-type
  labels       = local.common_tags

  zone = data.google_compute_zones.available.names[1]

  boot_disk {
    initialize_params {
      image  = "debian-cloud/debian-11"
      labels = local.common_tags
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
    echo '<html><head><title>Taco Team Server</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">You did it! Have a &#127790;</span></span></p><p>'$(curl http://metadata.google.internal/computeMetadata/v1/instance/hostname -H Metadata-Flavor:Google | cut -d . -f1)'</p></body></html>' | sudo tee /var/www/html/index.html
    SCRIPT
}