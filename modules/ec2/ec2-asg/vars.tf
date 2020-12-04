variable "subnets_ids_list" {
  type = list(string)
}
variable "min_size" {

}
variable "max_size" {

}
variable "asglc_name" {

}

variable "Name-tag" {
  description = "Name tag"
  default = "asg"
}
variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}