variable "name" {
  
}
variable "load_balancer_type" {
  
  default = "application"
}
variable "subnets" {
  type = list(string)
}
variable "security_groups" {
  type = list(string)
}
variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}