variable "region" {
  type        = string
  description = "GCP region"
}

variable "zone" {
  type        = string
  description = "GCP zone"
}

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "username" {
  type        = string
  description = "I think you'll figure this one out"
}

variable "common_tags" {
  type        = list
  description = "Implements the common tags scheme"
}

variable "machine_type" {
  type    = string
  default = "f1-micro"
}

variable "image" {
  type    = string
  default = "debian-cloud/debian-9"
}
