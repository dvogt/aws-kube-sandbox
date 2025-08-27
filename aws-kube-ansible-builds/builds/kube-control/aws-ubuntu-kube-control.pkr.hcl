# Must declare variables here

variable "project_name" {
  type = string
}

# Your AWS Account ID without dashes 
variable "aws_ami_owner_id" {
  type = list(string)
}

variable "ssh_username" {
  type = string
}

# AMI Image to pull from is the name of the image. 
# This image may be in different regions but will have different AMI IDs
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

locals {
  today = formatdate("YYYY-MM-DD-HH.mm", timestamp())
}

# -----------------------------

packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      version = "~> 1"
      source = "github.com/hashicorp/ansible"
    }
  }
}

# The source block defines where and how to create the base image.
# https://developer.hashicorp.com/packer/plugins/builders/amazon/ebs
source "amazon-ebs" "kube_control" {
  # skip_create_ami = true

  # The name of the resulting AMI
  ami_name = "kube-control-${local.today}"

  # The EC2 instance type to use while building the AMI
  instance_type = var.instance_type
  region        = var.region

  # Regions to copy the finished AMIs to
  ami_regions = var.ami_regions

  ssh_username = var.ssh_username

  # VPC filter
  # Get the VPC for var.project_anme
  vpc_filter {
    filters = {
      "tag:Name" = "${var.project_name}"
    }
  }

  # Get the Subnet from var.project_name
  subnet_filter {
    filters = {
      "tag:Name" = "${var.project_name}"
    }
  }

  # This prevents packer from creating a temporary security group that is too permissive
  security_group_filter {
    filters = {
      "tag:Name" = "${var.project_name}"
    }
  }

  source_ami_filter {
    filters = {
      name                = var.ami_image_to_pull_from #  the official Ubuntu AMI image on AWS
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = var.aws_ami_owner_id

  }
}


build {
  # Use to build the new AMI based on the source above. 
  # Since build can build multiple sources at the same time (virtualbox, AMI, etc.) 
  # the build is seperate from the source. 

  # The name of of the build used for logs.
  # This is optional but highly recommended
  name = "kube-control-${local.today}"

  # The source is listed above:
  #    source "amazon-ebs" "kube_control" {  
  sources = ["source.amazon-ebs.kube_control"]

  # The ansible playbook to run
  # This playbook references the shared Ansible files
  # This is the same Ansible playbook that Vagrant uses
  provisioner "ansible" {
    playbook_file = "kube-control.ansible.yml"
    use_proxy     = false
  }
}

