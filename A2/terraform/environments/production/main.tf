module "vpc" {
  source    = "../../modules/vpc"
  vpc_name  = "prod-vpc"
  cidr      = "10.2.0.0/16"

  public_subnets = [
    { name = "public-1", cidr = "10.2.1.0/24", az = "us-west-2a" },
    { name = "public-2", cidr = "10.2.2.0/24", az = "us-west-2b" },
    { name = "public-3", cidr = "10.2.3.0/24", az = "us-west-2c" }
  ]

  private_subnets = [
    { name = "private-1", cidr = "10.2.101.0/24", az = "us-west-2a" },
    { name = "private-2", cidr = "10.2.102.0/24", az = "us-west-2b" },
    { name = "private-3", cidr = "10.2.103.0/24", az = "us-west-2c" }
  ]
}
