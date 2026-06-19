# holden:ignore:HLD_TF_026 — examples intentionally use ../../ to reference the local module root
module "compute" {
  source                = "../../"
  zone                  = var.zone
  project_id            = var.project_id
  username              = var.username
  service_account_email = var.service_account_email
  network               = google_compute_network.main.self_link
  kms_key_self_link     = google_kms_crypto_key.main.id

  depends_on = [google_kms_crypto_key_iam_member.compute_service_agent]
}
