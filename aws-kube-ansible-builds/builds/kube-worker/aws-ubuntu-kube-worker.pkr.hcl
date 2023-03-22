
# Must declare variables here
# Values are declared here: ../../../aws-kube-shared/vars.pkr.hcl

# The owner id in AWS for Canonical 
variable "aws_owner_id" {
  type = list(string)
}

# Your AWS VPC ID from provided by Terraform
variable "vpc_id" {
  type = string
}

# Your AWS SUBNET in the AWS VPC provided by Terraform
variable "subnet_id" {
  type = string
}

# AMI Image to pull from is the name of the image. 
# This image may be in different regions but will have differfent AMI IDs
variable "ami_image_to_pull_from" {
  type = string
}

# Region where the image will be built
variable "region" {
  type = string
}

# The list of regions to copy the AMI to
variable "ami_regions" {
  type = list(string)
}

# The EC2 instance type to use while building the AMI
variable "instance_type" {
  type = string
}


packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# The source to build from
# https://developer.hashicorp.com/packer/plugins/builders/amazon/ebs
source "amazon-ebs" "kube_worker" {
  # The name of the resulting AMI
  ami_name = "kube-worker"

  # The EC2 instance type to use while building the AMI
  instance_type = var.instance_type
  region        = var.region

  # Regions to copy the finished AMIs to
  ami_regions = var.ami_regions

  # 
  source_ami_filter {
    filters = {
      name                = var.ami_image_to_pull_from
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = var.aws_owner_id
  }

  vpc_id    = var.vpc_id
  subnet_id = var.subnet_id

  ssh_username = "ubuntu"
}

build {
  # The name of of the build used for logs.
  # This is optional
  name = "kube-worker"

  # sources is listed above:
  #    source "amazon-ebs" "kube_worker" {
  sources = ["source.amazon-ebs.kube_worker"]

  # The ansible playbook. 
  # This  playbook reference to the shared Ansible files
  provisioner "ansible" {
    playbook_file = "kube-worker.yml"
    use_proxy     = false
  }
}

