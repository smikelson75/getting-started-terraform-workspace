## Unmanaged Instance Group (gcp-lb-instance-group)
resource "google_compute_instance_group" "usce1c-webservers" {
  name        = "gcp-webserver-group"
  description = "Terraform test instance group"

  instances = [
    google_compute_instance.web-server-instance.id
  ]

  named_port {
    name = "http"
    port = "80"
  }

  zone = data.google_compute_zones.available.names[2]
}

resource "google_compute_instance_group" "usce1b-webservers" {
  name        = "gcp-webserver2-group"
  description = "Terraform test instance group"

  instances = [
    google_compute_instance.web-server-instance2.id
  ]

  named_port {
    name = "http"
    port = "80"
  }

  zone = data.google_compute_zones.available.names[1]
}

## Backend
resource "google_compute_backend_service" "usce1c-webserver-backend" {
  name          = "usce1c-webserver-backend"
  health_checks = [google_compute_health_check.webserver-health-check.id]

  protocol  = "HTTP"
  port_name = "http"

  backend {
    group = google_compute_instance_group.usce1c-webservers.id
  }

  backend {
    group = google_compute_instance_group.usce1b-webservers.id
  }
}

## Health Check
resource "google_compute_health_check" "webserver-health-check" {
  name                = "webserver-health-check"
  timeout_sec         = 5
  check_interval_sec  = 30
  unhealthy_threshold = 3

  http_health_check {
    port = 80
  }
}

## URL Map
resource "google_compute_url_map" "webserver-url-map" {
  name            = "webserver-lb"
  default_service = google_compute_backend_service.usce1c-webserver-backend.id

}

## Target HTTP Proxy
resource "google_compute_target_http_proxy" "webserver-target-http-proxy" {
  name    = "webserver-target-http-proxy"
  url_map = google_compute_url_map.webserver-url-map.id
}

## Forwarding Rule/Load Balancer
resource "google_compute_global_forwarding_rule" "webserver-forwarding-rule" {
  name       = "webserver-forwarding-rule"
  target     = google_compute_target_http_proxy.webserver-target-http-proxy.id
  port_range = "80"
}