resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  project      = var.project_id
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {

    }
  }

  tags = var.common_tags
}
