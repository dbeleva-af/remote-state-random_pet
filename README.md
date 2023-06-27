# Terraform configuration for deployement of ec2 instance using terraform_remote_state data source 

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















  

