# IAM Role for EC2
resource "aws_iam_role" "ec2_role" {
  name = "ec2-instance-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

# IAM Instance Profile for EC2
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-profile"
  role = aws_iam_role.ec2_role.name
}

# Application Load Balancer
resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id] # Using ALB SG from security.tf
  subnets            = var.public_subnet_ids
}

# Target Group for Load Balancer
resource "aws_lb_target_group" "app_tg" {
  name     = "app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# Listener for Load Balancer
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

resource "aws_launch_template" "app_template" {
  name_prefix   = "app-template-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  
   # Use the generated key pair
  key_name      = aws_key_pair.generated_key.key_name

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  # Metadata Options
  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  # User Data Script to Set Up Application
    user_data = filebase64("${path.module}/userdata.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "app-instance"
    }
  }
}

# Auto Scaling Group (Keep instances in private subnets)
resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier = var.private_subnet_ids  #Using Private Subnets
  desired_capacity    = 2
  max_size           = 4
  min_size           = 2

  launch_template {
    id      = aws_launch_template.app_template.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.app_tg.arn]
}

# Generate a new private key
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create an EC2 key pair using the generated public key
resource "aws_key_pair" "generated_key" {
  key_name   = "dynamic-keypair"
  public_key = tls_private_key.ssh_key.public_key_openssh
}

# Save the private key locally
resource "local_file" "private_key" {
  filename        = "${path.module}/dynamic-keypair.pem"
  content         = tls_private_key.ssh_key.private_key_pem
  file_permission = "0400"  # Restrict file access
}
