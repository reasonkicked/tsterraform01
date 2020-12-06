resource "aws_route_table" "rtb_public" {
  vpc_id = var.vpc_id
route {
      cidr_block = "0.0.0.0/0"
      gateway_id = var.gateway_id
  }
tags = {
    Environment = var.environment_tag
    Name = var.Name
  }
}