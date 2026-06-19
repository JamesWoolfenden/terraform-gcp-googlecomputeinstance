resource "google_compute_route" "main" {
  name             = "pike-default-internet"
  project          = var.project_id
  network          = google_compute_network.main.self_link
  dest_range       = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}
