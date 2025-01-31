module "vpc" {
  source    = "../../modules/vpc"
  vpc_name  = "staging-vpc"
  cidr      = "10.1.0.0/16"

  public_subnets = [
    { name = "public-1", cidr = "10.1.1.0/24", az = "us-west-2a" },
    { name = "public-2", cidr = "10.1.2.0/24", az = "us-west-2b" },
    { name = "public-3", cidr = "10.1.3.0/24", az = "us-west-2c" }
  ]

  private_subnets = [
    { name = "private-1", cidr = "10.1.101.0/24", az = "us-west-2a" },
    { name = "private-2", cidr = "10.1.102.0/24", az = "us-west-2b" },
    { name = "private-3", cidr = "10.1.103.0/24", az = "us-west-2c" }
  ]
}
