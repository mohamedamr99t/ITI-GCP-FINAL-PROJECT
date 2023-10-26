provider "google" {
  project = var.project_id
  region  = "us-central1"
}

#Creating Bucket File
resource "google_storage_bucket" "statefile-backup" {
  name          = "tfstate-backup"
  location      = "US"
  force_destroy = true

  uniform_bucket_level_access = true

  cors {
    origin          = ["http://image-store.com"]
    method          = ["GET", "HEAD", "PUT", "POST", "DELETE"]
    response_header = ["*"]
    max_age_seconds = 3600
  }
}

module "network" {
  source        = "./network"
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
}
module "iam" {
  source = "./iam"
}
module "compute" {
  source                = "./compute"
  network-subnet        = module.network.management_subnet
  service_account_email = module.iam.service_account-management-email
  tag                   = module.network.firewall
}
module "gke" {
  source                         = "./gke"
  network-subnet                 = module.network.workload_subnet
  service_account_email          = module.iam.service_account-gke-email
  authorized_networks_cidr_range = var.ip_cidr_range[0]
}
module "storage" {
  source = "./storage"
}
