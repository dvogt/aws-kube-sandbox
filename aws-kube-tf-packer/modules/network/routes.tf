

# -----------------------------------------------
#             Public Routes
# -----------------------------------------------

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.packer.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.packer_ig.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.packer_ig.id
  }

  tags = {
    Name = "${var.project_name}-public"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.sn_packer.id
  route_table_id = aws_route_table.public.id
}




