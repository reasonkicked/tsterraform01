variable "vpc_id" {
  type = string
}

variable "environment_tag" {
  description = "Environment tag"
  default = "Production"
}