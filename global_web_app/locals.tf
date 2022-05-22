locals {
  common_tags = {
    company      = var.company
    project      = "${var.company}-${var.project}"
    billing_code = var.billing_code
  }
}

resource "random_integer" "rand" {
    min = 10000
    max = 99999
}