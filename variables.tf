variable "region" {}
variable "zone" {}
variable "project_id" {}

variable "username" {
  description = ""
}

variable "common_tags" {
  type = "map"
}

variable "depends_on" {
  type    = "list"
  default = []
}
