variable "environment" {}
variable "cluster_name" {}

variable "alb_subnets" {
  type = "list"
}

variable "vpc_id" {}

variable "alb_arn" {}

variable "alb_listener_arn" {}

variable "target_type" {
  default = "instance"
}

variable "app_index" {
  default = 1
}

variable "alb_protocols" {
  default = ["HTTP"]
}

variable "tld" {
  default = "ghost.instacarrot.com"
}

variable "host_port" {
  default = 2368
}
  
