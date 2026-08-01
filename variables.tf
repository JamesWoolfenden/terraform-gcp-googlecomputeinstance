

variable "project_id" {
  type        = string
  description = "GCP project ID"
  validation {
    condition     = length(trimspace(var.project_id)) > 0
    error_message = "The project ID must be a non-empty string."
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

variable "subnetwork" {
  type        = string
  default     = null
  description = "Self link of the subnetwork to attach the instance to. Required when network is a custom subnet-mode VPC (auto_create_subnetworks = false) -- GCP rejects instance creation on such a network without one."
  validation {
    condition     = var.subnetwork == null || length(trimspace(var.subnetwork)) > 0
    error_message = "The subnetwork, if set, must be a non-empty string."
  }
}

variable "kms_key_self_link" {
  type        = string
  description = "Self link of the KMS key used to encrypt the boot disk."
  sensitive   = true
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

variable "delete_protection" {
  description = "Whether to enable delete protection for the instance."
  type        = bool
  default     = true
}

variable "enable_confidential_compute" {
  description = "Enable Confidential VM. Requires a machine_type from a compatible family (N2D, C2D, N2, C3, C3D) -- incompatible with the f1-micro default."
  type        = bool
  default     = false
}
