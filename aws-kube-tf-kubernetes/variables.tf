
# ======================================================
# General Project Vars
# ======================================================

variable "aws_ami_owners" {
  description = "This is the owner account id for Ubuntu to tell Amazon where to pull the base image from to build the bastion host"
  type        = list(string)
  default     = ["099720109477"]
}

variable "aws_ami_images" {
  description = "This is the AMI image used for building the bastion host"
  type        = list(string)
  default     = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
}

variable "aws_ami_kube_control_images" {
  description = "This is the AMI image used for building the kube_control host"
  type        = list(string)
  default     = ["kube-control-*"]
}

variable "aws_ami_kube_worker_images" {
  description = "This is the AMI image used for building the kube_worker hosts"
  type        = list(string)
  default     = ["kube-worker-*"]
}

variable "project_name" {
  description = "Project Name is used for tags and naming of services"
  type        = string
  default     = "aws-kube-sandbox"
}

variable "ssh_pub_key_path" {
  description = "Public Key to be added to images to ssh into"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

# variable "aws_credentials_for_tf" {
#   description = "AWS credentials for Terraform to access AWS environment"
#   type        = list(string)
#   default     = ["../aws-kube-shared/aws-credentials"]
# }

variable "aws_region" {
  description = "AWS region to launch services."
  type        = string
  default     = "us-east-1"
}

variable "aws_az_1" {
  description = "AWS Availability to launch servers."
  type        = string
  default     = "us-east-1b"
}



# ======================================================
# General Networking
# ======================================================


variable "vpc_ipv6_netmask_length" {
  default = "56"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
  default     = "10.0.0.0/16"
}


# ===============================================
# Bastion Vars
# =============================================


variable "cidr_bastion" {
  description = "CIDR for bastion subnet"
  type        = string
  default     = "10.0.3.0/28"
}

variable "bastion_instance_type" {
  type    = string
  default = "t2.micro"
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
  default     = "10.0.5.0/24"
}

variable "kube_controller_ip" {
  description = "This is the IP of the kube controller"
  type        = string
  default     = "10.0.5.10"
}

variable "kube_workers_ips" {
  description = "This will determine how many workers are created."
  default = {
    "0" = "10.0.5.102"
    "1" = "10.0.5.103"
    # "2" = "10.0.5.104"
  }
}

variable "kub_worker_instance_type" {
  description = "Kube workers instance type"
  type        = string
  default     = "t2.medium"
}
