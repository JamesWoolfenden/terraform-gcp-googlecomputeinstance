# terraform-gcp-googlecomputeinstance

[![Build Status](https://github.com/JamesWoolfenden/terraform-gcp-googlecomputeinstance/workflows/Verify/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-gcp-googlecomputeinstance)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-gcp-googlecomputeinstance.svg)](https://github.com/JamesWoolfenden/terraform-gcp-googlecomputeinstance/releases/latest)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![checkov](https://img.shields.io/badge/checkov-verified-brightgreen)](https://www.checkov.io/)

Terraform module to provision a secure terraform state bucket for team use of IAC.

---

It's 100% Open Source and licensed under the [APACHE2](LICENSE).

## Usage

Include this repository as a module in your existing terraform code:

```hcl
module "compute" {
source      = "JamesWoolfenden/-googlecomputeinstance/gcp"
version     = "0.0.4"
common_tags = var.common_tags
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_instance.vm_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_project_metadata_item.username](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_project_metadata_item) | resource |
| [local_file.private](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.public](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [tls_private_key.ssh](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Implements the common tags scheme | `list(any)` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | n/a | `string` | `"debian-cloud/debian-9"` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | n/a | `string` | `"f1-micro"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | I think you'll figure this one out | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | GCP zone | `string` | `"us-central1-a"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Role and Permissions

<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
The Terraform resource required is:

```golang
resource "google_project_iam_custom_role" "terraformXVlBzgba" {
  project     = "examplea"
  role_id     = "terraform_pike"
  title       = "terraformXVlBzgba"
  description = "A user with least privileges"
  permissions = [
    "compute.disks.create",
    "compute.globalOperations.get",
    "compute.instances.create",
    "compute.instances.delete",
    "compute.instances.get",
    "compute.instances.setMetadata",
    "compute.instances.setTags",
    "compute.projects.get",
    "compute.projects.setCommonInstanceMetadata",
    "compute.subnetworks.use",
    "compute.subnetworks.useExternalIp",
    "compute.zones.get",
    "iam.serviceAccounts.actAs"
  ]
}

```
<!-- END OF PRE-COMMIT-PIKE DOCS HOOK -->

## Getting started with Terraform and Google Cloud

```cli
Terraform init
Terraform plan
```

This should fail as you dont have anything Google cloud set.

```cli
* provider.google: google: could not find default credentials. See https://developers.google.com/accounts/docs/application-default-credentials for more information.
```

This needs for your to set environmental variable
GOOGLE_APPLICATION_CREDENTIALS
This points to a json file.

## Step 1 install the google sdk cli

Windows:

```cli
choco install gcloudsdk
```

Or

Ubuntu:

```bash
# Create environment variable for correct distribution
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

# Add the Cloud SDK distribution URI as a package source
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Update the package list and install the Cloud SDK
sudo apt-get update && sudo apt-get install google-cloud-sdk
```

## Step 2 Authentication

Once you have the cli installed run:

```cli
gcloud init
```

and that will set up your cli environment.

Create a service account:

```cli
gcloud iam service-accounts create [NAME]
gcloud iam service-accounts create terraform
```

Associate it with your project:

```cli
gcloud projects add-iam-policy-binding [PROJECT_ID] --member "serviceAccount:[NAME]@[PROJECT_ID].iam.gserviceaccount.com" --role "roles/owner"
gcloud projects add-iam-policy-binding examplea --member "serviceAccount:terraform@examplea.iam.gserviceaccount.com" --role "roles/owner"
```

Now we can obtain our credentials file:
gcloud iam service-accounts keys create [FILE_NAME].json --iam-account [NAME]@[PROJECT_ID].iam.gserviceaccount.com

```cli
gcloud iam service-accounts keys create terraform.json --iam-account terraform@examplea.iam.gserviceaccount.com
```

I copied the json file to ~/.gcp and then run (or add to your .bashrc):
Ubuntu

```cli
export GOOGLE_APPLICATION_CREDENTIALS="/home/[username]/.gcp/terraform.json"
```

or Windows

```cli
$env:GOOGLE_APPLICATION_CREDENTIALS="c:\Users\[username]]\.gcp\terraform.json"
```

From:
<https://cloud.google.com/storage/docs/reference/libraries>

## Cooking with GAS

Once that var is in your shell you can terraform plan:

```cli
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + google_compute_instance.vm_instance
      id:                                                  <computed>
      boot_disk.#:                                         "1"
      boot_disk.0.auto_delete:                             "true"
      boot_disk.0.device_name:                             <computed>
      boot_disk.0.disk_encryption_key_sha256:              <computed>
      boot_disk.0.initialize_params.#:                     "1"
      boot_disk.0.initialize_params.0.image:               "debian-cloud/debian-9"
      boot_disk.0.initialize_params.0.size:                <computed>
      boot_disk.0.initialize_params.0.type:                <computed>
      can_ip_forward:                                      "false"
      cpu_platform:                                        <computed>
      create_timeout:                                      "4"
      deletion_protection:                                 "false"
      guest_accelerator.#:                                 <computed>
      instance_id:                                         <computed>
      label_fingerprint:                                   <computed>
      machine_type:                                        "f1-micro"
      metadata_fingerprint:                                <computed>
      name:                                                "terraform-instance"
      network_interface.#:                                 "1"
      network_interface.0.access_config.#:                 "1"
      network_interface.0.access_config.0.assigned_nat_ip: <computed>
      network_interface.0.access_config.0.nat_ip:          <computed>
      network_interface.0.access_config.0.network_tier:    <computed>
      network_interface.0.address:                         <computed>
      network_interface.0.name:                            <computed>
      network_interface.0.network:                         "default"
      network_interface.0.network_ip:                      <computed>
      network_interface.0.subnetwork_project:              <computed>
      project:                                             <computed>
      scheduling.#:                                        <computed>
      self_link:                                           <computed>
      tags_fingerprint:                                    <computed>
      zone:                                                <computed>


Plan: 1 to add, 0 to change, 0 to destroy.

```

Fill your boots.

## Connect

Try:

```cli
gcloud compute --project "examplea" ssh --zone "us-central1-c" "terraform-instance"
```

This will add a folder and key into your profile if your dont have one.

```cli
WARNING: The public SSH key file for gcloud does not exist.
WARNING: The private SSH key file for gcloud does not exist.
WARNING: You do not have an SSH key for gcloud.
WARNING: SSH keygen will be executed to generate a key.
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/jim/.ssh/google_compute_engine.
Your public key has been saved in /home/jim/.ssh/google_compute_engine.pub.
```

## Related Projects

Check out these related projects.

- [terraform-aws-s3](https://github.com/jameswoolfenden/terraform-aws-s3) - S3 buckets

## Help

**Got a question?**

File a GitHub [issue](https://github.com/JamesWoolfenden/terraform-gcp-googlecomputeinstance/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/JamesWoolfenden/terraform-gcp-googlecomputeinstance/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2019-2023 James Woolfenden

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements. See the NOTICE file
distributed with this work for additional information
regarding copyright ownership. The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

[![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage] |

[jameswoolfenden_homepage]: https://github.com/jameswoolfenden
[jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150
