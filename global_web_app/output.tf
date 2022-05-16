output "gcp_instance_public_ip" {
  value = google_compute_instance.web-server-instance.network_interface[0].access_config[0].nat_ip
}