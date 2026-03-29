resource "aws_vpc" "netflix_app_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name        = "${var.project_name}-${var.environment}-vpc"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_subnet" "netflix_public_subnet" {
  vpc_id                  = aws_vpc.netflix_app_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-public-subnet"
  }
}

resource "aws_internet_gateway" "netflix_igw" {
  vpc_id = aws_vpc.netflix_app_vpc.id

  tags = {
    Name = "${var.project_name}-${var.environment}-igw"
  }
}

resource "aws_route_table" "netflix_route_table" {
  vpc_id = aws_vpc.netflix_app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.netflix_igw.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-rt"
  }
}

resource "aws_route_table_association" "netflix_rta" {
  subnet_id      = aws_subnet.netflix_public_subnet.id
  route_table_id = aws_route_table.netflix_route_table.id
}
