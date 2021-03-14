variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "project_id" {
  type = string
}

variable "username" {
  type        = string
  description = ""
}

variable "common_tags" {
  type = list(any)
}
