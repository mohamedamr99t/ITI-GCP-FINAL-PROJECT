resource "google_artifact_registry_repository" "cluster-storage" {
  location      = "us-central1"
  repository_id = "cluster-storage"
  description   = "the cluster storage"
  format        = "DOCKER"
}
