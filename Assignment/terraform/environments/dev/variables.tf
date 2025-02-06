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

