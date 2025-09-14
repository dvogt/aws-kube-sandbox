

# ======================================================
# General Project Vars
# ======================================================

variable "aws_ami_owners" {
  description = "This is the owner account id for Ubuntu to tell Amazon where to pull the base image from to build the bastion host"
  type        = list(string)
  default     = []
}

variable "aws_ami_images" {
  description = "This is the AMI image used for building the bastion host"
  type        = list(string)
  default     = []
}

variable "aws_ami_kube_control_images" {
  description = "This is the AMI image used for building the kube_control host"
  type        = list(string)
  default     = []
}

variable "aws_ami_kube_worker_images" {
  description = "This is the AMI image used for building the kube_worker hosts"
  type        = list(string)
  default     = []
}

variable "k8s_ssm_join" { 
  description = "SSM name used to store the join command used by workers."
  type        = string
  default     = "" 
}


variable "k8s_secrets_config" { 
  description = "Secret name to be to store kbs adm config file over 8K"
  type        = string
  default     = "" 
}


variable "project_name" {
  description = "Project Name is used for tags and naming of services"
  type        = string
  default     = ""
}

variable "ssh_pub_key_path" {
  description = "Public Key to be added to images to ssh into"
  type        = string
  default     = ""
}

# variable "aws_credentials_for_tf" {
#   description = "AWS credentials for Terraform to access AWS environment"
#   type        = list(string)
#   default     = ["../aws-kube-shared/aws-credentials"]
# }

variable "aws_region" {
  description = "AWS region to launch services."
  type        = string
  default     = ""
}

variable "aws_az_1" {
  description = "AWS Availability to launch servers."
  type        = string
  default     = ""
}



# ======================================================
# General Networking
# ======================================================


variable "vpc_ipv6_netmask_length" {
  default = ""
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
  default     = ""
}


# ===============================================
# Bastion Vars
# =============================================


variable "cidr_bastion" {
  description = "CIDR for bastion subnet"
  type        = string
  default     = ""
}

variable "bastion_instance_type" {
  type    = string
  default = ""
}

variable "bastion_disable_api_termination" {
  type    = string
  default = false
}


# ======================================================
# Kube Workers
# ======================================================

variable "cidr_kube_workers" {
  description = "CIDR for Kube Workers subnet"
  type        = string
  default     = ""
}

variable "kube_controller_ip" {
  description = "This is the IP of the kube controller"
  type        = string
  default     = ""
}

variable "kube_workers_ips" {
  description = "This will determine how many workers are created."
  # To add more worker nodes, add to the list below. 
  # The mapping needs to start with zero or it will break Terraform
  default = {}
}

variable "kub_worker_instance_type" {
  description = "Kube workers instance type"
  type        = string
  default     = ""
}

variable "controller_r53_ttl" {
  description = "TTL for records in seconds"
  type        = string
  default     = ""
}

variable "controller_hosted_zone" {
  description = "A and AAAAA records for controller "
  type        = string
  default     = ""
}

variable "controller_r53_record" {
  description = "Subdomain for hosted zone. Example: k8s.aws.dvogt.net"
  type        = string
  default     = ""
}

