variable "project" {
  type        = string
  description = "The GCP project to generate to"
}

variable "gcp_region" {
  type        = string
  description = "GCP Region to use for resources"
  default     = "us-central1"
}

variable "vpc-auto-create-subnets" {
  type        = bool
  description = "Create Auto-mode Subnet for GCP Regions"
  default     = false
}

variable "vpc-subnet-cidr-block" {
  type        = string
  description = "CIDR Block for NGINX Subnet"
  default     = "10.0.0.0/24"
}

variable "instance-machine-type" {
  type        = string
  description = "Machine type for Compute Engine"
  default     = "f1-micro"
}

variable "company" {
  type        = string
  description = "Company name for resource tagging"
  default     = "globomantics"
}

variable "billing_code" {
  type        = string
  description = "Billing code for resource tagging"
}