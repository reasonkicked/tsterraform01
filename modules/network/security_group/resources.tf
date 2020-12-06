resource "aws_security_group" "security_group" {
  name = var.name
  vpc_id = var.vpc_id
  # Allow inbound HTTP requests
  ingress {
    from_port   = var.sg_from_port
    to_port     = var.sg_to_port
    protocol    = var.sg_protocol
    cidr_blocks  = var.cidr_vpc
    //security_groups = [var.security_groups_ids]
  }

  # Allow all outbound requests
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
  }
}