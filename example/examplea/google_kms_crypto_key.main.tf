resource "google_kms_crypto_key" "main" {
  name     = "pike-disk-key"
  key_ring = google_kms_key_ring.main.id
  purpose  = "ENCRYPT_DECRYPT"
  lifecycle {
    prevent_destroy = true
  }
  rotation_period = "7776000s"

  # 30 days, matching the default Cloud KMS applies to console-created keys.
  # Unset would leave only 24h to recover a key version destroyed by mistake,
  # after which every disk encrypted under it is unrecoverable.
  destroy_scheduled_duration = "2592000s"
}
