# Terraform configuration for deployement of ec2 instance using terraform_remote_state data source 

# Description

This directory contains 3 subfolders which purpose is to upload resources in groups one after another. The main goal is for the server to use output value for ami_id from the state file in the remote state backend after the AMI is created. Sequence for applying the configuration from every folder.

1. backend
2.  ami
3. server

## Prerequisites

- git
- terraform (>=1.5)
- AWS account
- AWS credentials configured to work with terraform

## Configuration

- Create `main.tf` file for the backend
```
bucket         = "remote-state-1"
key            = "dev/terraform.tfstate"
region         = "us-west-2"
encrypt        = true
```

- Create `variables.tf` file for the AMI
``` 
variable "region" {}
variable "instance_type" {}
```
- Create `main.tf` file for the AMI
```
backend "s3" {}
data "aws_ami" "ubuntu" {}
resource "random_pet" "server" {}
```
-  Create `outputs.tf` file for the AMI
```
output "ami_id" {
value = data.aws_ami.ubuntu.id
}
```

- Create `variables.tf` file for the SERVER
```
variable "region" {}
variable "instance_type" {}
```

- Create `main.tf` file for the SERVER
```
backend "s3" {}
data "terraform_remote_state" "ami" {}
resource "random_pet" "server" {}
resource "aws_instance" "server" {}
```

## Inputs


| Name  |	Description |	Type |  Default |	Required
| ----- | ----------- | ---- |  ------- | --------
| access_key | Requester AWS access key | string | - | yes
| secret_key | Requester AWS secret key | string | - | yes
| region | Requester AWS region | string | "us-west-2" | no
| backend | Remote State | string | - | yes
| ami_id | AMI ID for server | string | yes


### Initialize terraform and plan/apply

```
$ terraform init
$ terraform plan
$ terraform apply
```

- `Terraform apply` will:
  - create the backend
  - create AMI 
  - create ec2 instance and random_pet resource
    
#### Outputs

| Name  |	Description 
| ----- | ----------- 
| ami_id | The ID of ami after creation
| ec2 instance ID  | ID of the resource named server
| dev/ | directory in remote-state-1 bucket for terraform.tfstate file for AMI
| server/ | directory in remote-state-1 for terraform.tfstate file for the ec2 instance












  

