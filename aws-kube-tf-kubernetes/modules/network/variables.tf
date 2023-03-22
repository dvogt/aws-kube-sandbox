
variable "region" {
  type    = string
  default = ""
}

variable "aws_az_1" {
  type    = string
  default = ""
}

variable "vpc_cidr" {
  type    = string
  default = ""
}

variable "ingress_ip_v6" {
  type    = string
  default = ""
}

variable "ingress_ip_v4" {
  type    = string
  default = ""
}

variable "project_name" {
  type    = string
  default = ""
}

variable "cidr_bastion" {
  type    = string
  default = ""
}

variable "cidr_kube_workers" {
  type    = string
  default = ""
}


