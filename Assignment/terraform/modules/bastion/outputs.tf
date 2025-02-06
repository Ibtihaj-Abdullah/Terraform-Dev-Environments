output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "bastion_private_ip" {
  value = aws_instance.bastion.private_ip
}

output "private_key_path" {
  value = local_file.private_key.filename
}

output "key_pair_name" {
  value = aws_key_pair.bastion_key_pair.key_name
}
