output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "public_subnet_1" {
  value = aws_subnet.subnet_public_1.id
}
output "public_subnet_2" {
  value = aws_subnet.subnet_public_2.id
}
output "public_route_table_ids" {
  value = [aws_route_table.rtb_public_1.id]
}
output "dbsg" {
  value = aws_security_group.sg_3306.id
}