module "compute" {
  source      = "../../"
  common_tags = "${var.common_tags}"
  region      = "${var.region}"
  zone        = "${var.zone}"
  project_id  = "${var.project_id}"
  username    = "${var.username}"
}
