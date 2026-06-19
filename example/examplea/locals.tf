locals {
  region = replace(var.zone, "/-[a-z]$/", "")
}
