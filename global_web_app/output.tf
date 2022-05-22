output "gcp_instance_public_ip" {
  value = google_compute_global_forwarding_rule.webserver-forwarding-rule.ip_address
}