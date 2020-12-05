resource "aws_nat_gateway" "nat_gw" {
  allocation_id = var.allocation_id //aws_eip.nat.id
  subnet_id     = var.subnet_id //aws_subnet.example.id
  
}