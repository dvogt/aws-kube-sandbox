

data "aws_ami" "kube_controller_ami" {
  # Latest build
  most_recent = true
  # AWS Account ID where AMI is pulled from.
  owners = ["self"]

  filter {
    name   = "name"
    values = var.aws_ami_kube_control_images
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "kube_worker_ami" {
  # Latest build
  most_recent = true
  # AWS Account ID where AMI is pulled from.
  owners = ["self"]

  filter {
    name   = "name"
    values = var.aws_ami_kube_worker_images
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "latest_ubuntu" {
  # Latest build
  most_recent = true
  # AWS Account ID of the AMI will be using to build from. 
  owners = var.aws_ami_owners

  filter {
    name   = "name"
    values = var.aws_ami_images
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
