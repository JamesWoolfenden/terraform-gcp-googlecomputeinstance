resource "google_compute_router" "main" {
  name    = "pike-router"
  project = var.project_id
  network = google_compute_network.main.self_link
  region  = local.region
}
