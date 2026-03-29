provider "aws" {
  region = var.region
}

module "netflix_ec2_instance" {
  source = "./modules/ec2"

  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id = aws_subnet.netflix_public_subnet.id
  security_group_ids = [aws_security_group.netflix_app_sg.id]

  project_name = var.project_name
  environment  = var.environment
}
