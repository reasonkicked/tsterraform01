
resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = var.subnet_id
  route_table_id = var.route_table_id
}