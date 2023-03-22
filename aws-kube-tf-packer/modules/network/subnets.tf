
# Create a subnet to launch our instances into

# An interface that is part of a NAT gateway cannot be the next hop 
# for an IPv6 destination CIDR block outside the CIDR range 64:ff9b::/96 or IPv6 prefix list.

resource "aws_subnet" "sn_packer" {
  vpc_id                  = aws_vpc.packer.id
  cidr_block              = var.cidr_packer
  map_public_ip_on_launch = true

  ipv6_cidr_block                 = cidrsubnet(aws_vpc.packer.ipv6_cidr_block, 8, 1)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "${var.project_name}"
  }
}




