variable "load_balancer_arn" {
  
}
variable "port" {
    default = 80
}
variable "protocol" {
  default = "HTTP"
}
variable "type" {
  default = "fixed-response"
}
variable "content_type" {
  default = "fixed-response"
}
variable "message_body" {
  default = "404: page not found"
}
variable "status_code" {
  default = 404
}
variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}