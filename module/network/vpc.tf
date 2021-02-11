resource "aws_vpc" "demo" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "demoVPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.demo.id
  availability_zone = var.az
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = "true"

  tags = {
    Name = "PublicSubnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.demo.id
  availability_zone = var.az
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = "PrivateSubnet"
  }
}

resource "aws_internet_gateway" "demoigw" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = "demoIGW"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demoigw.id
  }

  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = "PrivateRouteTable"
  }
}

resource "aws_route_table_association" "public_ra" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_ra" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_security_group" "allow_bastion_internet" {
  name        = "allow_bastion_internet"
  description = "Allow Bastion Instance to connect to Internet"
  vpc_id      = aws_vpc.demo.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["*****************"] #Include any custom IP or set CIDR to 0.0.0.0/0 (all IP) to access Bastion Host
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_bastion_internet"
  }
}
