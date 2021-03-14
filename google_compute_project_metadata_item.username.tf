resource "google_compute_project_metadata_item" "username" {
  project = var.project_id
  key     = "ssh-keys2"
  value   = "${var.username}:${tls_private_key.ssh.public_key_openssh}"
}
