

data "aws_ami" "kube_controller_ami" {
  most_recent = true
  # AWS Account ID being worked on
  owners = ["self"]

  filter {
    name   = "name"
    values = ["kube-control"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "kube_worker_ami" {
  # Latest build
  most_recent = true
  # AWS Account ID being worked on
  owners = ["self"]

  filter {
    name   = "name"
    values = ["kube-worker"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "latest_ubuntu" {
  # Latest build
  most_recent = true
  # Owner of the AMI will be using to build from
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
