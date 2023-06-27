terraform {
  backend "s3" {
     encrypt        = true
     bucket         = "remote-state-1"
     key            = "dev/terraform.tfstate"
     region         = "us-west-2"
   }
 
 required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

/*
resource "aws_s3_bucket" "tf_state" {
  bucket = "learn-s3-remote-backend"

  force_destroy = true

  // lifecycle {
  //   prevent_destroy = true
  // }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-state-lock-dynamo"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
   }
}
*/


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
     name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "random_pet" "server" {
  keepers = {
    ami_id = data.aws_ami.ubuntu.id
  }
}

