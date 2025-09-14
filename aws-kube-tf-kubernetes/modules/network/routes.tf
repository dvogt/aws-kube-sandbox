
# -----------------------------------------------
#             Public and Bastion Routes
# -----------------------------------------------

# Create route table for public subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.kubernetes.id

  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_internet_gateway.internet_gateway.id
  # }

  # This needs to be here becuase we allow restrcited IPv6 to connect this subnet
  # route {
  #   ipv6_cidr_block = "::/0"
  #   gateway_id      = aws_internet_gateway.internet_gateway.id
  # }

  tags = {
    Name = "${var.project_name}-public"
  }
}

resource "aws_route" "ipv4_internet" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route" "ipv6_internet" {
  route_table_id         = aws_route_table.public_rt.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}
# Associate route table with Bastion (Public) subnet
resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.sn_bastion.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "kube_workers" {
  subnet_id      = aws_subnet.sn_kub_workers.id
  route_table_id = aws_route_table.public_rt.id
}


# ==============================================================
#                    Kube
# ==============================================================

# Create route table for Kube subnet
# resource "aws_route_table" "to_eigw_and_nat" {
#   vpc_id = aws_vpc.kubernetes.id

#   # This needs to be here becuase we allow restrcited IPv6 to connect this subnet
#   # This can only be applied after the init apply
#   # route {
#   #   ipv6_cidr_block = "::/0"
#   #   gateway_id      = aws_internet_gateway.internet_gateway.id
#   # }

#   tags = {
#     Name = "${var.project_name}-to-eigw-and-nat"
#   }
# }

# Add IPv6 route for Kube subnet to Egress Internet Gateway
# resource "aws_route" "kub_to_eigw" {
#   route_table_id              = aws_route_table.to_eigw_and_nat.id
#   egress_only_gateway_id      = aws_egress_only_internet_gateway.eigw_ipv6.id
#   destination_ipv6_cidr_block = "::/0"
# }

# resource "aws_route" "kub_to_eigw" {
#   route_table_id              = aws_route_table.to_eigw_and_nat.id
#   egress_only_gateway_id      = aws_internet_gateway.internet_gateway.id
#   destination_ipv6_cidr_block = "::/0"
# }



# Associate route table with Kube subnet
# resource "aws_route_table_association" "kube_workers" {
#   subnet_id      = aws_subnet.sn_kub_workers.id
#   route_table_id = aws_route_table.to_eigw_and_nat.id
# }


