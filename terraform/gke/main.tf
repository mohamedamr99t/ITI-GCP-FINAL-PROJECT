
resource "google_container_cluster" "gke_cluster" {
  name               = "my-cluster"
  location           = var.network-subnet.region
  initial_node_count = 1
  network            = var.network-subnet.network
  subnetwork         = var.network-subnet.name


  addons_config {
    http_load_balancing {
      disabled = false
    }
  }
  deletion_protection = false
  node_config {
    service_account = var.service_account_email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/devstorage.read_write"
    ]

    machine_type = "e2-small"
    disk_size_gb = 10
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = var.authorized_networks_cidr_range
    }
  }
  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"

    master_global_access_config {
      enabled = true
    }
  }
}
