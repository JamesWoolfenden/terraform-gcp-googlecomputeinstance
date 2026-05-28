# holden:ignore:HLD_TF_026 — examples intentionally use ../../ to reference the local module root
module "compute" {
  source      = "../../"
  common_tags = var.common_tags
  region      = var.region
  zone        = var.zone
  project_id  = var.project_id
  username    = var.username
}
