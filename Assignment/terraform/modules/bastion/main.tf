# Security Group for Bastion Host
resource "aws_security_group" "bastion_sg" {
  name_prefix = "bastion-sg-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Generate a new private key
resource "tls_private_key" "bastion_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create a key pair in AWS
resource "aws_key_pair" "bastion_key_pair" {
  key_name   = "${var.environment}-bastion-key"
  public_key = tls_private_key.bastion_key.public_key_openssh
}

# Save the private key locally
resource "local_file" "private_key" {
  filename        = "${path.module}/${var.environment}-bastion-key.pem"
  content         = tls_private_key.bastion_key.private_key_pem
  file_permission = "0400"
}

# Bastion Host Instance
resource "aws_instance" "bastion" {
  ami           = var.ami_id
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_id
  security_groups = [aws_security_group.bastion_sg.id]
  key_name        = aws_key_pair.bastion_key_pair.key_name
  associate_public_ip_address = true
  tags = {
    Name = "${var.environment}-bastion"
  }
}
