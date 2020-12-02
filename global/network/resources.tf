resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Environment = var.environment_tag
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Environment = var.environment_tag
  }
}

resource "aws_subnet" "subnet_public_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_subnet_1
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone_1
  tags = {
    Environment = var.environment_tag
  }
}
resource "aws_subnet" "subnet_public_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_subnet_2
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone_2
  tags = {
    Environment = var.environment_tag
  }
}

resource "aws_route_table" "rtb_public_1" {
  vpc_id = aws_vpc.vpc.id
route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }
tags = {
    Environment = var.environment_tag
  }
}
resource "aws_route_table" "rtb_public_2" {
  vpc_id = aws_vpc.vpc.id
route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }
tags = {
    Environment = var.environment_tag
  }
}
resource "aws_route_table_association" "rta_subnet_public_1" {
  subnet_id      = aws_subnet.subnet_public_1.id
  route_table_id = aws_route_table.rtb_public_1.id
}
resource "aws_route_table_association" "rta_subnet_public_2" {
  subnet_id      = aws_subnet.subnet_public_2.id
  route_table_id = aws_route_table.rtb_public_2.id
}

resource "aws_security_group" "sg_22" {
  name = "sg_22"
  vpc_id = aws_vpc.vpc.id
  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Environment = var.environment_tag
  }
}
resource "aws_security_group" "sg_80" {
  name = "sg_80"
  vpc_id = aws_vpc.vpc.id
  ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Environment = var.environment_tag
  }
}
resource "aws_security_group" "sg_8080" {
  name = "sg_8080"
  vpc_id = aws_vpc.vpc.id
  ingress {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
 
  tags = {
    Environment = var.environment_tag
  }
}
resource "aws_security_group" "sgalb_80" {
  name = "sgalb_80"
  vpc_id = aws_vpc.vpc.id
  # Allow inbound HTTP requests
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


