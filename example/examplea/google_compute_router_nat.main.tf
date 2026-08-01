resource "google_compute_router_nat" "main" {
  name                               = "pike-nat"
  project                            = var.project_id
  router                             = google_compute_router.main.name
  region                             = local.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  min_ports_per_vm                   = 128

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
