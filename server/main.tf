terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "remote-state-1"
    key            = "learn-terraform-s3-migrate-tfc"
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

data "terraform_remote_state" "ami" {
  backend = "s3"
  config  = {
    bucket = "remote-state-1"
    key    = "dev/terraform.tfstate"
    region = "us-west-2"
  }
}

resource "random_pet" "server" {
  keepers = {
    ami_id = "${data.terraform_remote_state.ami.outputs.ami_id}"
  }
}

resource "aws_instance" "server" {
  instance_type = var.instance_type
  ami           = "${data.terraform_remote_state.ami.outputs.ami_id}"

  tags = {
    Name = "web-server-${random_pet.server.id}"
  }
}

