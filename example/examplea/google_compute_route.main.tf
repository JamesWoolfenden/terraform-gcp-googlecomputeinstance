# Egress replacement route for a network created with
# delete_default_routes_on_create = true. Deliberately narrow: it covers only
# the Private Google Access VIP range, so instances can reach Google APIs but
# have no general internet egress. google_dns_managed_zone.googleapis is what
# makes googleapis.com resolve into this range -- the two go together.
resource "google_compute_route" "main" {
  name             = "pike-google-apis"
  project          = var.project_id
  network          = google_compute_network.main.self_link
  dest_range       = "199.36.153.8/30"
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}
