

#  ------------------------------------------------------------

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.kubernetes.id

  tags = {
    Name = var.project_name
  }
}

# IPv6 Gateway. This doesn't need to go through a NAT Gateway
resource "aws_egress_only_internet_gateway" "eigw_ipv6" {
  vpc_id = aws_vpc.kubernetes.id

  tags = {
    Name = var.project_name
  }
}
