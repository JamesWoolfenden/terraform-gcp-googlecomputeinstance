variable "zone" {
  type        = string
  description = "The GCP zone within the selected region."

  validation {
    condition     = length(trimspace(var.zone)) > 0
    error_message = "The zone must be a non-empty string."
  }
}

variable "project_id" {
  type        = string
  description = "The GCP project ID to deploy resources into."

  validation {
    condition     = length(trimspace(var.project_id)) > 0
    error_message = "The project_id must be a non-empty string."
  }
}

variable "username" {
  type        = string
  description = "The user name for the instance or resources."

  validation {
    condition     = length(trimspace(var.username)) > 0
    error_message = "The username must be a non-empty string."
  }
}

variable "service_account_email" {
  type        = string
  description = "Email of the service account to attach to the instance."

  validation {
    condition     = length(trimspace(var.service_account_email)) > 0
    error_message = "The service_account_email must be a non-empty string."
  }
}
