output "ami_id" {
  description = "The AMI ID after apply"
  value       = data.aws_ami.ubuntu.id
}

output "instance_id" {
  description = "The id after apply"
  value       = resource.aws_instance.server.id
}
