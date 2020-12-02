variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default = "10.1.0.0/16"
}
variable "cidr_subnet_1" {
  description = "CIDR block for the subnet"
  default = "10.1.1.0/24"
}
variable "cidr_subnet_2" {
  description = "CIDR block for the subnet"
  default = "10.1.2.0/24"
}
variable "availability_zone_1" {
  description = "availability zone to create subnet"
  default = "us-west-2a"
}
variable "availability_zone_2" {
  description = "availability zone to create subnet"
  default = "us-west-2b"
}
variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}
