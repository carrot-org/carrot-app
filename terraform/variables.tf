variable "environment" {
  default = "dev"
}
variable "cluster_name" {
  default = "ecsDevelopmentCluster"
}

variable "alb_subnets" {
  default = ["subnet-0500df997a79b21ba", "subnet-087fed9bb915ea415"]
  type = "list"
}

variable "vpc_id" {
  default = "vpc-0afc5c1ebcb391eec"
}

variable "alb_arn" {
  default = "arn:aws:elasticloadbalancing:us-west-1:532332872873:loadbalancer/app/ghost-lb-tf/efc19e2936750142"
}

variable "alb_listener_arn" {
  default = "arn:aws:elasticloadbalancing:us-west-1:532332872873:listener/app/ghost-lb-tf/efc19e2936750142/83430c542741d6cf"
}

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
  
