# terraform-gcp-googlecomputeinstance

[![Build Status](https://github.com/JamesWoolfenden/terraform-gcp-googlecomputeinstance/workflows/Verify%20and%20Bump/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-gcp-googlecomputeinstance)
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
| google | n/a |
| local | n/a |
| tls | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| common\_tags | Implements the common tags scheme | `list` | n/a | yes |
| image | n/a | `string` | `"debian-cloud/debian-9"` | no |
| machine\_type | n/a | `string` | `"f1-micro"` | no |
| project\_id | GCP project ID | `string` | n/a | yes |
| region | GCP region | `string` | n/a | yes |
| username | I think you'll figure this one out | `string` | n/a | yes |
| zone | GCP zone | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

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
gcloud projects add-iam-policy-binding focused-elysium-224508 --member "serviceAccount:terraform@focused-elysium-224508.iam.gserviceaccount.com" --role "roles/owner"
```

Now we can obtain our credentials file:
gcloud iam service-accounts keys create [FILE_NAME].json --iam-account [NAME]@[PROJECT_ID].iam.gserviceaccount.com

```cli
gcloud iam service-accounts keys create terraform.json --iam-account terraform@focused-elysium-224508.iam.gserviceaccount.com
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
gcloud compute --project "focused-elysium-224508" ssh --zone "us-central1-c" "terraform-instance"
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

Copyright © 2019-2021 James Woolfenden

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
[github]: https://github.com/jameswoolfenden
[linkedin]: https://www.linkedin.com/in/jameswoolfenden/
[twitter]: https://twitter.com/JimWoolfenden
[share_twitter]: https://twitter.com/intent/tweet/?text=terraform-gcp-googlecomputeinstance&url=https://github.com/JamesWoolfenden/terraform-gcp-googlecomputeinstance
[share_linkedin]: https://www.linkedin.com/shareArticle?mini=true&title=terraform-gcp-googlecomputeinstance&url=https://github.com/JamesWoolfenden/terraform-gcp-googlecomputeinstance
[share_reddit]: https://reddit.com/submit/?url=https://github.com/JamesWoolfenden/terraform-gcp-googlecomputeinstance
[share_facebook]: https://facebook.com/sharer/sharer.php?u=https://github.com/JamesWoolfenden/terraform-gcp-googlecomputeinstance
[share_email]: mailto:?subject=terraform-gcp-googlecomputeinstance&body=https://github.com/JamesWoolfenden/terraform-gcp-googlecomputeinstance
