
variable "module_name" {
  type    = string
  default = "kub-workers"
}

variable "kube_workers_ips" {
  type = map(any)
}

variable "kube_controller_ip" {
  type    = string
  default = ""
}

variable "k8s_ssm_join" {
  type    = string
  default = ""
}

variable "k8s_secrets_config" {
  type    = string
  default = ""
}

variable "controller_r53_record" {
  type        = string
  default     = ""
}

variable "project_name" {
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

variable "kube_worker_ami" {
  type    = string
  default = ""
}

variable "kube_controller_ami" {
  type    = string
  default = ""
}

variable "ssh_key" {
  type    = string
  default = ""
}

variable "sn_kub_workers" {
  type    = any
  default = ""
}

variable "kub_worker_instance_type" {
  type    = string
  default = ""
}

# variable "kub_security_groups" {
#   type = list(any)
# }

variable "sg_bastion_id" {
  type    = string
  default = ""
}

variable "aws_region" {
  type = string
  default = ""
  
}

variable "ingress_ip_v6" {
  type    = string
  default = ""
}

variable route_table {
  type    = any
  default = ""
}

# variable "ansible_security_groups" {
#   type    = string
#   default = ""
# }




