resource "google_compute_network" "main" {
  name                            = "pike-vpc"
  project                         = var.project_id
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
}

# holden:ignore:HLD_GCP_047
resource "google_compute_firewall" "main" {
  name    = "pike-allow-iap-ssh"
  project = var.project_id
  network = google_compute_network.main.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # IAP TCP forwarding range: https://cloud.google.com/iap/docs/using-tcp-forwarding
  source_ranges = ["35.235.240.0/20"]
}
