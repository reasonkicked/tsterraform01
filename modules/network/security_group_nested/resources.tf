resource "aws_security_group" "security_group" {
  name = var.security_group_name
  vpc_id = var.subnet_vpc_id
  # Allow inbound HTTP requests
  ingress {
    from_port   = var.sg_from_port
    to_port     = var.sg_to_port
    protocol    = var.sg_protocol
    //cidr_blocks  = var.cidr_vpc
    security_groups = var.security_groups_ids
  }

  # Allow all outbound requests
  egress {
    from_port   = var.sg_from_port
    to_port     = var.sg_from_port
    protocol    = var.sg_protocol
    //cidr_blocks  = var.cidr_vpc
    security_groups = var.security_groups_ids
  }
}