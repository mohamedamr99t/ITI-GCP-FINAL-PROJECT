#Create_Vpc
resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  description             = "network vpc"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}
#Create Management Subnet 
resource "google_compute_subnetwork" "management_subnet" {
  name          = "management-subnet"
  ip_cidr_range = var.ip_cidr_range[0]
  region        = var.region[0]
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "workload_subnet" {
  name          = "workload-subnet"
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = var.ip_cidr_range[1]
  region        = var.region[1]
}

# Create a router
resource "google_compute_router" "router" {
  name    = "my-router"
  region  = var.region[0]
  network = google_compute_network.vpc_network.id
}
# Create Cloud NAT
resource "google_compute_router_nat" "google_compute_router_natloud-nat" {
  name                   = "my-router-nat"
  router                 = google_compute_router.router.name
  region                 = google_compute_router.router.region
  nat_ip_allocate_option = "AUTO_ONLY"
  # Allow connections only from the management subnet
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.management_subnet.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}
resource "google_compute_firewall" "iap-firewall" {
  name          = "iap-firewall"
  network       = google_compute_network.vpc_network.id
  source_ranges = ["35.235.240.0/20"]
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["firewall-rule"]

}