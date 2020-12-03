resource "aws_subnet" "subnet_public" {
  vpc_id = var.subnet_vpc_id
  cidr_block = var.cidr_subnet
  map_public_ip_on_launch = "true"
  availability_zone = var.subnet_az
  tags = {
    Environment = var.environment_tag
  }
}