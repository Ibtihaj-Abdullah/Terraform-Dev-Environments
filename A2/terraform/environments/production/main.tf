module "vpc" {
  source    = "../../modules/vpc"
  vpc_name= "main"
}

module "ec2" {
  source             = "../../modules/ec2"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = [module.vpc.public_subnet_2_id, module.vpc.public_subnet_3_id]  # Use Public Subnet 1 for ALB
  private_subnet_ids = [module.vpc.private_subnet_2_id] # Use Private Subnet 1 for Dev ASG

  ami_id        = var.ami_id
  instance_type = var.instance_type
}

module "bastion" {
  source           = "../../modules/bastion"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.vpc.public_subnet_2_id
  ami_id           = var.ami_id
  allowed_ip       = "0.0.0.0/0"  # Replace with your IP address
  environment      = "prod"
}
