

variable "project_id" {
  type        = string
  description = "GCP project ID"
  validation {
    condition     = length(trimspace(var.project_id)) > 0
    error_message = "The project ID must be a non-empty string."
  }
}

variable "username" {
  type        = string
  description = "I think you'll figure this one out"
  validation {
    condition     = length(trimspace(var.username)) > 0
    error_message = "The username must be a non-empty string."
  }
}

variable "machine_type" {
  type        = string
  default     = "f1-micro"
  description = "machine type"
  validation {
    condition     = length(trimspace(var.machine_type)) > 0
    error_message = "The machine_type must be a non-empty string."
  }
}

variable "image" {
  type        = string
  default     = "debian-cloud/debian-9"
  description = "image type"
  validation {
    condition     = length(trimspace(var.image)) > 0
    error_message = "The image must be a non-empty string."
  }
}

variable "zone" {
  default     = "us-central1-a"
  type        = string
  description = "GCP zone"
  validation {
    condition     = length(trimspace(var.zone)) > 0
    error_message = "The zone must be a non-empty string."
  }
}

variable "network" {
  type        = string
  description = "The self_link or name of the VPC network to attach to the instance."
  validation {
    condition     = length(trimspace(var.network)) > 0 && var.network != "default"
    error_message = "The network must be a non-empty string and cannot be the default network."
  }
}

variable "kms_key_self_link" {
  type        = string
  description = "Self link of the KMS key used to encrypt the boot disk."
  validation {
    condition     = length(trimspace(var.kms_key_self_link)) > 0
    error_message = "The kms_key_self_link must be a non-empty string."
  }
}



variable "service_account_email" {
  type        = string
  description = "Email of the service account to attach to the instance, instead of the default Compute Engine service account."
  validation {
    condition     = length(trimspace(var.service_account_email)) > 0
    error_message = "The service_account_email must be a non-empty string."
  }
}

# holden:ignore:HLD_TF_021
variable "scopes" {
  description = "Scopes for instance"
  type        = list(string)
  default     = []
}
