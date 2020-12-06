variable "cidr_vpc" {
  default = ["0.0.0.0/0"]
  description = "CIDR block for the VPC"
}
variable "name" {

}
variable "vpc_id" {
  
}
variable "sg_from_port" {
  
}
variable "sg_to_port" {
  
}
variable "sg_protocol" {
  default = "tcp"
}/*
variable "security_groups_ids" {
  type = list
}
*/

variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}