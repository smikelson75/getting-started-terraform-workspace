resource "google_storage_bucket" "site-storage" {
  name                        = local.storage_bucket_name
  location                    = "us-central1"
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "logo" {
  bucket = local.storage_bucket_name
  source = "website/Globo_logo_Vert.png"
  name   = "logo"
}

resource "google_storage_bucket_object" "homepage" {
  bucket = local.storage_bucket_name
  source = "website/index.html"
  name   = "homepage"
}