# Security Group for EC2
resource "aws_security_group" "alb_sg" {
  name   = "alb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
    security_groups = [var.alb_sg_id]   # Only ALB can access
  }
  
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups= [var.alb_sg_id]
  }

   ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # for testing (later restrict)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_template" "lt" {
  name_prefix   = "app-"
  image_id      = var.ami_id
  instance_type = "t3.micro"

  key_name = var.key_name

  network_interfaces {
  associate_public_ip_address = true
  security_groups = [aws_security_group.alb_sg.id]
}



 user_data = base64encode(<<EOF
#!/bin/bash

dnf update -y
dnf install -y nginx

systemctl enable nginx
systemctl start nginx

# wait to ensure nginx is ready
sleep 20

echo "<h1>Hello from terraform!!!</h1>" > /usr/share/nginx/html/index.html

EOF
)
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity = 2
  max_size         = 3
  min_size         = 1

  vpc_zone_identifier = var.private_subnets

  health_check_grace_period = 300   # ✅ ADD THIS

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]
}