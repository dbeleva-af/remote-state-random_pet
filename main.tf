terraform {
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

data "terraform_remote_state" "server" {
  backend = "remote"

  config = {
    organization = "diana-viktorova"
    workspaces = {
      name = "server"
    }
  }
}

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

resource "aws_instance" "server" {
  instance_type = var.instance_type
  ami           = data.aws_ami.ubuntu.id
  tags = {
    Name = "web-server-${random_pet.server.id}"
  }
}
