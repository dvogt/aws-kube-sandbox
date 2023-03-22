
variable "module_name" {
  type    = string
  default = "cp-bastion"
}

variable "project_name" {
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

variable "aws_vpc_id" {
  type    = string
  default = ""
}

variable "latest_ubuntu_ami" {
  type    = string
  default = ""
}

variable "aws_subnet_bastion" {
  type    = string
  default = ""
}


variable "ssh_key" {
  type    = string
  default = ""
}


variable "bastion_instance_type" {
  type    = string
  default = ""
}

variable "bastion_disable_api_termination" {
  type    = string
  default = ""
}

