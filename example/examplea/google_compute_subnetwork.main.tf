resource "google_compute_subnetwork" "main" {
  name                     = "pike-subnet"
  project                  = var.project_id
  network                  = google_compute_network.main.self_link
  region                   = local.region
  ip_cidr_range            = "10.0.0.0/24"
  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}
