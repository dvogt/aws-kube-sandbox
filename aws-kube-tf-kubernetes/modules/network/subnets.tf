# Create a subnet to launch our instances into

# An interface that is part of a NAT gateway cannot be the next hop 
# for an IPv6 destination CIDR block outside the CIDR range 64:ff9b::/96 or IPv6 prefix list.

resource "aws_subnet" "sn_bastion" {
  vpc_id                  = aws_vpc.kubernetes.id
  cidr_block              = var.cidr_bastion
  map_public_ip_on_launch = false

  ipv6_cidr_block                 = cidrsubnet(aws_vpc.kubernetes.ipv6_cidr_block, 8, 1)
  assign_ipv6_address_on_creation = true
  availability_zone               = var.aws_az_1

  tags = {
    Name = "${var.project_name}-bastion"
  }
}

resource "aws_subnet" "sn_kub_workers" {
  vpc_id                  = aws_vpc.kubernetes.id
  cidr_block              = var.cidr_kube_workers
  map_public_ip_on_launch = false

  ipv6_cidr_block                 = cidrsubnet(aws_vpc.kubernetes.ipv6_cidr_block, 8, 2)
  assign_ipv6_address_on_creation = true
  availability_zone               = var.aws_az_1


  tags = {
    Name = "${var.project_name}-kub"
  }
}


