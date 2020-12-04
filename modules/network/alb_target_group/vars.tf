variable "name" {
  
}
variable "port" {
    default = 80
}
variable "protocol" {
  default = "HTTP"
}
variable "vpc_id" {
 
}
variable "path" {
  default = "/"
}
variable "matcher" {
  default = "200"
}
variable "interval" {
  default = 15
}
variable "timeout" {
  default = 3
}
variable "healthy_threshold" {
  default = 2
}
variable "unhealthy_threshold" {
  default = 2
}
variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}