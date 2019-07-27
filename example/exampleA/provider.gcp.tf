provider "google" {
  project = "focused-elysium-224508"
  region  = "europe-west1"
  version = "2.10"
}

provider "local" {
  version = "1.3"
}

provider "tls" {
  version = "2.0.1"
}
