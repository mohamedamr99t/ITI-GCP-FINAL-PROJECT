resource "google_storage_bucket" "gcp-bucket-demo" {
  name          = "bucket-demo"
  location      = "EU"
  force_destroy = true

  uniform_bucket_level_access = false
}

terraform {
 backend "gcs" {
   bucket  = "gcp-bucket-demo"
   prefix  = "terraform/state"
 }
}
