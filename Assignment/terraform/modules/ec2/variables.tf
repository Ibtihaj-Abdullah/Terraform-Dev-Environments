variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "The VPC ID where resources will be deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ALB deployment"
  type        = list(string)
}

variable "private_subnet_ids" {  # ✅ Keep only this for private subnets
  description = "List of private subnet IDs for ASG and EC2 deployment"
  type        = list(string)
}
