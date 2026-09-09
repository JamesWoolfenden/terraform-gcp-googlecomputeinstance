# Resolves googleapis.com to the private.googleapis.com VIPs covered by
# google_compute_route.main. Without this, Private Google Access resolves the
# API names to public addresses the narrow egress route does not reach.
resource "google_dns_managed_zone" "googleapis" {
  name        = "pike-googleapis"
  project     = var.project_id
  dns_name    = "googleapis.com."
  description = "Private Google Access resolution for googleapis.com"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.main.id
    }
  }

  cloud_logging_config {
    enable_logging = true
  }
}

resource "google_dns_record_set" "private_googleapis" {
  name         = "private.googleapis.com."
  project      = var.project_id
  managed_zone = google_dns_managed_zone.googleapis.name
  type         = "A"
  ttl          = 300
  rrdatas      = ["199.36.153.8", "199.36.153.9", "199.36.153.10", "199.36.153.11"]
}

resource "google_dns_record_set" "googleapis_wildcard" {
  name         = "*.googleapis.com."
  project      = var.project_id
  managed_zone = google_dns_managed_zone.googleapis.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["private.googleapis.com."]
}
