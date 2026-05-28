
resource "google_project_iam_custom_role" "terraform_pike" {
  project     = "pike-477416"
  role_id     = "terraform_pike"
  title       = "terraform_pike"
  description = "A user with least privileges"
  permissions = [
    "compute.disks.create",
    "compute.disks.setLabels",
    "compute.globalOperations.get",
    "compute.instances.create",
    "compute.instances.delete",
    "compute.instances.get",
    "compute.instances.setLabels",
    "compute.instances.setMetadata",
    "compute.instances.setTags",
    "compute.instances.updateNetworkInterface",
    "compute.projects.get",
    "compute.projects.setCommonInstanceMetadata",
    "compute.subnetworks.use",
    "compute.subnetworks.useExternalIp",
    "compute.zones.get"
  ]
}
