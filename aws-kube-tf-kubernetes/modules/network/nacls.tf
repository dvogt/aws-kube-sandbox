# resource "aws_network_acl" "bastion" {
#   vpc_id     = aws_vpc.kubernetes.id
#   subnet_ids = [aws_subnet.sn_bastion.id]



#   egress {
#     protocol = "6"
#     # protocol 6 = tcp
#     rule_no    = 203
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 65535
#   }


#   egress {
#     protocol = "6"
#     # protocol 6 = tcp
#     rule_no         = 205
#     action          = "allow"
#     ipv6_cidr_block = "::/0"
#     from_port       = 0
#     to_port         = 65535
#   }

#   egress {
#     protocol   = "icmp"
#     rule_no    = 207
#     action     = "allow"
#     cidr_block = "0.0.0.0/0"
#     from_port  = 0
#     to_port    = 0
#   }

#   # egress {
#   #   protocol        = "icmpv6"
#   #   rule_no         = 207
#   #   action          = "allow"
#   #   ipv6_cidr_block = "::/0"
#   #   from_port       = 0
#   #   to_port         = 0
#   # }

#   # ingress {
#   #   protocol   = "icmp"
#   #   rule_no    = 100
#   #   action     = "allow"
#   #   cidr_block = "0.0.0.0/0"
#   #   from_port  = 0
#   #   to_port    = 0
#   # }

#   ingress {
#     protocol = "58"
#     # protocol        = "58" = icmpv6
#     rule_no         = 102
#     action          = "allow"
#     ipv6_cidr_block = "::/0"
#     from_port       = 0
#     to_port         = 0
#   }

#   ingress {
#     protocol        = "tcp"
#     rule_no         = 103
#     action          = "allow"
#     ipv6_cidr_block = var.ingress_ip_v6
#     from_port       = 22
#     to_port         = 22
#   }

#   ingress {
#     protocol   = -1
#     rule_no    = 106
#     action     = "allow"
#     cidr_block = "10.0.7.0/24"
#     from_port  = 0
#     to_port    = 0
#   }


#   tags = {
#     Name = "${var.project_name} bastion"
#   }
# }


# # resource "aws_network_acl_association" "bastion" {
# #   network_acl_id = aws_network_acl.bastion.id
# #   subnet_id      = aws_subnet.sn_bastion.id
# # }
