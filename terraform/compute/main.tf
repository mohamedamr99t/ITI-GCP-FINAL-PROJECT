resource "google_compute_instance" "vmmanagement" {
  name         = "vmmanagement"
  machine_type = var.machine_type
  zone         = "${var.network-subnet.region}-b"
  tags         = var.tag
  boot_disk {
    initialize_params {
      image = var.disk-image
    }
  }


  network_interface {
    network    = var.network-subnet.network
    subnetwork = var.network-subnet.name

  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }
  metadata_startup_script = var.startup_script
}
