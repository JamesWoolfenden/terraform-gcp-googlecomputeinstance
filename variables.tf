variable "region" {
  description = "GCP region"
}

variable "zone" {
  description = "GCP zone"
}

variable "project_id" {
  description = "GCP project ID"
}

variable "username" {
  description = ""
}

variable "common_tags" {
  type        = "list"
  description = "Implements the common tags scheme"
}

variable "depends_on" {
  type    = "list"
  default = []
}
