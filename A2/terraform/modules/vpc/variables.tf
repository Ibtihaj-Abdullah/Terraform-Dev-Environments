variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Enable or disable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable or disable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "additional_tags" {
  description = "Additional tags to apply to VPC resources"
  type        = map(string)
  default     = {}
}
