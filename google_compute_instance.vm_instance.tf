resource "google_compute_instance" "vm_instance" {
  # checkov:skip=CKV_GCP_38: "todo add csek"
  # checkov:skip=CKV_GCP_32: "Ensure 'Block Project-wide SSH keys' is enabled for VM instances"
  # checkov:skip=CKV_GCP_39: "Ensure Compute instances are launched with Shielded VM enabled"
  # checkov:skip=CKV_GCP_30: "Ensure that instances are not configured to use the default service account"
  name         = "terraform-instance"
  project      = var.project_id
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
  }

  tags = var.common_tags
}
