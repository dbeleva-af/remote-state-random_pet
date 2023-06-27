variable "region" {
  description  = "The name of the required region"
  type  = string
  default = "us-west-2"
}

variable "instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
}

