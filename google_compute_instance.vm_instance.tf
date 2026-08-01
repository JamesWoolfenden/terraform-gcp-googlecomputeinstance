# holden:ignore:HLD_GCP_019 — labels are supplied via the caller's provider-level
# default_labels (merged into terraform_labels/effective_labels by the google
# provider); this module intentionally doesn't duplicate them as a resource attribute.
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  project      = var.project_id
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
    kms_key_self_link = var.kms_key_self_link
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
  }

  service_account {
    email  = var.service_account_email
    scopes = var.scopes
  }

  metadata = {
    enable-oslogin         = "TRUE"
    block-project-ssh-keys = "true"
  }

  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  confidential_instance_config {
    enable_confidential_compute = var.enable_confidential_compute
  }

  deletion_protection = var.delete_protection
}
