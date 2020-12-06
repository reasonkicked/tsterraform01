variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  //default = "10.1.0.0/16"
}

variable "subnet_vpc_id" {

}
variable "subnet_az" {

}
variable "availability_zone" {
  description = "availability zone to create subnet"
  default = "us-west-2a"
}

variable "Name-tag" {
  description = "Name of the instance"
  default = "ec2-tslnx"
}
variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}