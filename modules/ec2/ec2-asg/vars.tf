variable "subnets_ids_list" {
  type = list(string)
}
variable "min_size" {

}
variable "max_size" {

}
variable "launch_configuration" {

}
variable "target_group_arns" {
  type = list(string)
}
variable "health_check_grace_period" {
  default = 120
}
variable "Name-tag" {
  description = "Name tag"
  default = "asg"
}
variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}