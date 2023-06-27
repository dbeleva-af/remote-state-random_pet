terraform {
  backend "s3" {
    bucket         = "remote-state-1"
    key            = "dev/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
  }
}


