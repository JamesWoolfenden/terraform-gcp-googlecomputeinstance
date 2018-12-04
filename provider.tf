provider "google" {
  region  = "${var.region}"
  zone    = "${var.zone}"
  version = "1.19"
}

provider "local" {
  version = "1.1"
}

provider "tls" {
  version = "1.2"
}
