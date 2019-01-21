resource "google_compute_project_metadata_item" "username" {
  project = "focused-elysium-224508"
  key     = "ssh-keys"
  value   = "${var.username}:${tls_private_key.ssh.public_key_openssh}"
}
