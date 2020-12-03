variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default = "10.1.0.0/16"
}


variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}
variable "vpc_name" {
  default = "vpc"  
}