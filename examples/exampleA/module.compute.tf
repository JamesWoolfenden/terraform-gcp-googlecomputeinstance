module "compute" {
  source      = "github.com/JamesWoolfenden/terraform-gcp-googlecomputeinstance"
  common_tags = "${var.common_tags}"
  region      = "${var.region}"
  zone        = "${var.zone}"
  project_id  = "${var.project_id}"
  username    = "${var.username}"
}
