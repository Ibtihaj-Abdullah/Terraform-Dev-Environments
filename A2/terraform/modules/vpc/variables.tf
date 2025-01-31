variable "vpc_name" {
  type = string
}

variable "cidr" {
  type = string
}

variable "public_subnets" {
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))
}

variable "private_subnets" {
  type = list(object({
    name = string
    cidr = string
    az   = string
  }))
}
