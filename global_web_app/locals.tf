locals {
  common_tags = {
    company      = var.company
    project      = "${var.company}-${var.project}"
    billing_code = var.billing_code
  }

  storage_bucket_name = "globo-web-app-${random_integer.rand.result}"
}

resource "random_integer" "rand" {
  min = 10000
  max = 99999
}