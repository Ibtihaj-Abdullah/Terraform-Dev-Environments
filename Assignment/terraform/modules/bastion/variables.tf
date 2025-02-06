variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_id" {
  description = "The ID of the public subnet for the bastion host"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the bastion host"
  type        = string
}

variable "allowed_ip" {
  description = "IP allowed to SSH into the bastion host"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}
