

#  ------------------------------------------------------------

# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "packer_ig" {
  vpc_id = aws_vpc.packer.id

  tags = {
    Name = var.project_name
  }
}


resource "aws_egress_only_internet_gateway" "eigw_ipv6" {
  vpc_id = aws_vpc.packer.id

  tags = {
    Name = var.project_name
  }
}
