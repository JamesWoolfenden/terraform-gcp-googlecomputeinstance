resource "google_kms_crypto_key" "main" {
  name     = "pike-disk-key"
  key_ring = google_kms_key_ring.main.id
  purpose  = "ENCRYPT_DECRYPT"
  lifecycle {
    prevent_destroy = true
  }
  rotation_period = "7776000s"
}
