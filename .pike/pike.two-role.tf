
# apply role — full permissions for terraform apply
# Bind this role to the applier SA on protected branches only.
resource "google_project_iam_custom_role" "terraform_pike_apply" {
  project     = "pike-477416"
  role_id     = "terraform_pike_apply"
  title       = "terraform_pike_apply"
  description = "Pike apply role — full permissions for terraform apply"
  permissions = [
    "compute.disks.create",
    "compute.disks.setLabels",
    "compute.instances.create",
    "compute.instances.delete",
    "compute.instances.get",
    "compute.instances.setLabels",
    "compute.instances.setMetadata",
    "compute.instances.updateNetworkInterface",
    "compute.subnetworks.use",
    "compute.subnetworks.useExternalIp",
    "compute.zones.get"
  ]
}

# plan role — read-only permissions for terraform plan
# Bind this role to the planner SA on all branches.
resource "google_project_iam_custom_role" "terraform_pike_plan" {
  project     = "pike-477416"
  role_id     = "terraform_pike_plan"
  title       = "terraform_pike_plan"
  description = "Pike plan role — read-only permissions for terraform plan"
  permissions = [
    "compute.instances.get",
    "compute.zones.get"
  ]
}
