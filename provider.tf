provider "google" {
  region  = "${var.region}"
  zone    = "${var.zone}"
  version = "1.19"
}
