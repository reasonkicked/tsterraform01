variable "instance_ami" {
  description = "AMI for aws EC2 instance"
  default = "ami-0e472933a1395e172"
}
variable "instance_type" {
  description = "type for aws EC2 instance"
  default = "t2.micro"
}
variable "security_groups_for_ec2" {
  type = list(string)
}

variable "key_pair_for_ec2" {

}
/*

variable "user_data_script" {
  type        = string
  description = "User data content"
}
*/

variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}