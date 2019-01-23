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

# this is enables you to add dependancies
variable depends_on {
  default     = []
  description = "This is a way to make a module depends on, which isnt built in."
  type        = "list"
}
