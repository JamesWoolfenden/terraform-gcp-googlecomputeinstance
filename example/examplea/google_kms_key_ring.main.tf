resource "google_kms_key_ring" "main" {
  name     = "pike"
  project  = var.project_id
  location = local.region
}
