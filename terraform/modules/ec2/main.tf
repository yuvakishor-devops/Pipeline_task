resource "aws_instance" "netflix_app_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  associate_public_ip_address = true

  user_data = <<-EOF
#!/bin/bash

# Update system
sudo apt update -y

# Install Docker
sudo apt install docker.io -y

# Start Docker
sudo systemctl start docker
sudo systemctl enable docker

# Pull Docker image from DockerHub
sudo docker pull yuvakishor/my-netflix-app:v1.0

# Run container
sudo docker run -d -p 5000:5000 yuvakishor/my-netflix-app:v1.0

EOF

tags = {
    Name = "${var.project_name}-${var.environment}-ec2"
    Environment = var.environment
    Project     = var.project_name
    Owner       = "YuvaKishor"
  }
}
