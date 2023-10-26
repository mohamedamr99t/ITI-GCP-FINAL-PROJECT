# Create management VM service account
resource "google_service_account" "management_sa" {
  account_id   = "management-sa"
  display_name = "Management VM Service Account"
}
# Create GKE service account
resource "google_service_account" "gke_sa" {
  account_id   = "gke-sa"
  display_name = "GKE Service Account"
}

resource "google_project_iam_custom_role" "management_role" {
  role_id     = "management_role_demo"
  title       = "Management Service Account Role"
  permissions = var.permissions-roles-management
}

resource "google_project_iam_custom_role" "gke_role" {
  role_id     = "gke_role_demo"
  title       = "GKE Service Account Role"
  permissions = var.permissions-roles-gke
}

resource "google_project_iam_binding" "service-accounts-binding-management" {
  project = var.project_id
  role    = google_project_iam_custom_role.management_role.id

  members = [google_service_account.management_sa.member]
}

resource "google_project_iam_binding" "service-accounts-binding-gke" {
  project = var.project_id
  role    = google_project_iam_custom_role.gke_role.id
  members = [google_service_account.gke_sa.member]
}
