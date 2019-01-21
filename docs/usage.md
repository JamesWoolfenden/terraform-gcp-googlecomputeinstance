# Getting started with Terraform and Google Cloud
```
Terraform init
Terraform plan
```
This should fail as you dont have anything Google cloud set.
```
* provider.google: google: could not find default credentials. See https://developers.google.com/accounts/docs/application-default-credentials for more information.
```
This needs for your to set environmental variable
GOOGLE_APPLICATION_CREDENTIALS
This points to a json file.

## Step 1 install the google sdk cli
Windows:
```
choco install gcloudsdk
```
Or

Ubuntu:

```
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
```
gcloud init
```
and that will set up your cli environment.

Create a service account:
gcloud iam service-accounts create [NAME]
```
gcloud iam service-accounts create terraform
```

Associate it with your project:
gcloud projects add-iam-policy-binding [PROJECT_ID] --member "serviceAccount:[NAME]@[PROJECT_ID].iam.gserviceaccount.com" --role "roles/owner"
```
gcloud projects add-iam-policy-binding focused-elysium-224508 --member "serviceAccount:terraform@focused-elysium-224508.iam.gserviceaccount.com" --role "roles/owner"
```
Now we can obtain our credentials file:
gcloud iam service-accounts keys create [FILE_NAME].json --iam-account [NAME]@[PROJECT_ID].iam.gserviceaccount.com

```
gcloud iam service-accounts keys create terraform.json --iam-account terraform@focused-elysium-224508.iam.gserviceaccount.com
```

I copied the json file to ~/.gcp and then run (or add to your .bashrc):
Ubuntu
```
export GOOGLE_APPLICATION_CREDENTIALS="/home/[username]/.gcp/terraform.json"
```
or Windows
```
$env:GOOGLE_APPLICATION_CREDENTIALS="c:\Users\[username]]\.gcp\terraform.json"
```

From:
https://cloud.google.com/storage/docs/reference/libraries

## Cooking with GAS
Once that var is in your shell you can terraform plan:

```
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

## Connect?
Try:
```
gcloud compute --project "focused-elysium-224508" ssh --zone "us-central1-c" "terraform-instance"
```
This will add a folder and key into your profile if your dont have one.
```
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
