provider "google" {
  project = var.project_id
  region  = "us-central1"
}

terraform {
  backend "gcs" {
    bucket = "bucket-final-gcp"
    prefix = "terraform/state"
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
  startup_script        = file("./startup.sh")

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
