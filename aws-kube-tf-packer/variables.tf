

# ======================================================
# General Project Vars
# ======================================================

variable "project_name" {
  type    = string
  default = "packer_vpc"
}

# variable "aws_credentials_for_tf" {
#   description = "AWS credentials for Terraform to access AWS environment"
#   type        = list(string)
#   default     = ["../aws-kube-shared/aws-credentials"]
# }

# ======================================================
# General Networking
# ======================================================

variable "aws_region" {
  description = "AWS region to launch servers."
  type        = string
  default     = "us-east-1"
}

variable "vpc_ipv6_netmask_length" {
  type    = string
  default = "56"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "cidr_packer" {
  type    = string
  default = "10.0.3.0/28"
}

