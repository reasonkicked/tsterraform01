resource "aws_route_table" "nat_gw_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.cidr_block
    nat_gateway_id = var.nat_gateway_id
  }
  tags = {
    Name = var.Name
  }
  
}