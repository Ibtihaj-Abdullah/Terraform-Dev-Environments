variable "ami_id" {
  description = "The AMI ID for EC2 instances"
  type        = string
  default     = "ami-00c257e12d6828491"  # Replace with your actual AMI ID
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ALB deployment"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for ASG and EC2 deployment"
  type        = list(string)
  default     = ["subnet-abc12345", "subnet-def67890", "subnet-ghi54321"]  # Replace with actual Subnet IDs
}
