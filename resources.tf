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

resource "aws_subnet" "subnet_public" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_subnet
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zone
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

resource "aws_route_table" "rtb_public" {
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
resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rtb_public.id
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






resource "aws_key_pair" "ec2key" {
  key_name = "publicKey"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "tsawslnx01" {
  ami           = var.instance_ami
  instance_type = var.instance_type

    user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  subnet_id = aws_subnet.subnet_public.id
  vpc_security_group_ids = [aws_security_group.sg_22.id, aws_security_group.sg_8080.id]
  key_name = aws_key_pair.ec2key.key_name
 tags = {
  Environment = var.environment_tag
  Name = "tsawslnx01"
  Owner = "tstanislawczyk"
 }
}

resource "aws_launch_configuration" "tslc01" {
  image_id        = var.instance_ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.sg_22.id, aws_security_group.sg_8080.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  lifecycle {
  create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "tsasg01" {
  launch_configuration = aws_launch_configuration.tslc01.name

  //availability_zones = ["us-west-2a"]
  vpc_zone_identifier       = [aws_subnet.subnet_public.id]
  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
        propagate_at_launch = true
  }
 
}

resource "aws_lb" "tsalb01" {
  name               = "tsalb01"
  load_balancer_type = "application"
  subnets            = [aws_subnet.subnet_public.id, aws_subnet.subnet_public_2.id]
  security_groups    = [aws_security_group.sgalb_80.id]
}

resource "aws_lb_target_group" "tsasg01" {
  name     = "terraform-asg-example"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.tsalb01.arn
  port              = 80
  protocol          = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}