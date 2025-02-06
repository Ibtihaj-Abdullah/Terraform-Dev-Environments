output "prod_vpc_id" {
  value = module.vpc.vpc_id
}

output "prod_alb_dns_name" {
  value = module.ec2.alb_dns_name
}

output "prod_autoscaling_group_arn" {
  value = module.ec2.autoscaling_group
}

output "public_subnet_1_id" {
  value = module.vpc.public_subnet_1_id
}

output "public_subnet_2_id" {
  value = module.vpc.public_subnet_2_id
}

output "public_subnet_3_id" {
  value = module.vpc.public_subnet_3_id
}
output "bastion_public_ip" {
  value = module.bastion.bastion_public_ip
}

output "bastion_private_key_path" {
  value = module.bastion.private_key_path
}

output "bastion_key_pair_name" {
  value = module.bastion.key_pair_name
}
