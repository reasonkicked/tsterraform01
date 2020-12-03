
resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = var.public_subnet_id
  route_table_id = var.public_rtb_id
}