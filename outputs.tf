output "instance" {
  value       = google_compute_instance.vm_instance
  description = "The created Compute Engine instance."
  sensitive   = true
}
