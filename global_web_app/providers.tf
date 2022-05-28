terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.21"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}

# Provider: GCP
provider "google" {
  project = var.project
  region  = var.gcp_region
}