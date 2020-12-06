# Creating an Route Table Association of the NAT Gateway route 
# table with the Private Subnet!
resource "aws_route_table_association" "nat_gw_rt_association" {

#  Private Subnet ID for adding this route table to the DHCP server of Private subnet!
  subnet_id      = var.subnet_id //aws_subnet.subnet2.id

# Route Table ID
  route_table_id = var.route_table_id //aws_route_table.NAT-Gateway-RT.id
}