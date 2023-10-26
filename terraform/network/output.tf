output "vpc_network" {
  value = google_compute_network.vpc_network

}

output "management_subnet" {
  value = {
    region  = google_compute_subnetwork.management_subnet.region
    project = google_compute_subnetwork.management_subnet.project
    name    = google_compute_subnetwork.management_subnet.name
    network = google_compute_subnetwork.management_subnet.network
  }
}

output "workload_subnet" {
  value = {
    region  = google_compute_subnetwork.workload_subnet.region
    project = google_compute_subnetwork.workload_subnet.project
    name    = google_compute_subnetwork.workload_subnet.name
    network = google_compute_subnetwork.workload_subnet.network
  }
}

output "firewall" {
  value = google_compute_firewall.iap-firewall.target_tags
}
