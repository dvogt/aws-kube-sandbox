
resource "aws_security_group" "sg_bastion" {
  name        = "sg_bastion"
  description = "${var.project_name} bastion"
  vpc_id      = var.aws_vpc_id

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

########################################################################
########################## INGRESS RULES ###############################
########################################################################

resource "aws_vpc_security_group_ingress_rule" "ingress_ipv4_icmp_kub_sg" {
  description       = "ingress_icmp_kub_sg"
  security_group_id = aws_security_group.sg_bastion.id

  referenced_security_group_id = var.sg_kub_workers_id
  ip_protocol                  = "icmp"
  from_port                    = -1
  to_port                      = -1

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_ssh_kub_sg" {
  description       = "SSH from your workstation using IPv4"
  security_group_id = aws_security_group.sg_bastion.id

  # cidr_blocks       = [var.ingress_ip_v4]
  referenced_security_group_id = var.sg_kub_workers_id
  ip_protocol                  = "tcp"
  from_port                    = 22
  to_port                      = 22

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

# UNCOMMENT FOR IPV4
# resource "aws_vpc_security_group_ingress_rule" "ingress_ipv4_ssh_client" {
#   description       = "SSH from your workstation using IPv6"
#   security_group_id = aws_security_group.sg_bastion.id

#   cidr_ipv4   = var.ingress_ip_v4
#   ip_protocol = "tcp"
#   from_port   = 22
#   to_port     = 22

#   tags = {
#     Name = "${var.project_name} ${var.module_name}"
#   }
# }

resource "aws_vpc_security_group_ingress_rule" "ingress_ipv6_ssh_client" {
  description       = "SSH from your workstation using IPv6"
  security_group_id = aws_security_group.sg_bastion.id

  cidr_ipv6   = var.ingress_ip_v6
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_ipv6_icmp_client" {
  description       = "ICMP from your workstation using IPv6"
  security_group_id = aws_security_group.sg_bastion.id

  cidr_ipv6   = var.ingress_ip_v6
  ip_protocol = "icmpv6"
  from_port   = -1
  to_port     = -1

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

# UNCOMMENT FOR IPV4
# resource "aws_vpc_security_group_ingress_rule" "ingress_ipv4_icmp_client" {
#   description       = "ingress_icmp_client"
#   security_group_id = aws_security_group.sg_bastion.id

#   cidr_ipv4   = var.ingress_ip_v4
#   ip_protocol = "icmp"
#   from_port   = -1
#   to_port     = -1

#   tags = {
#     Name = "${var.project_name} ${var.module_name}"
#   }
# }

########################################################################
########################## EGRESS RULES#################################
########################################################################

resource "aws_vpc_security_group_egress_rule" "egress_ipv6_80" {
  description       = "egress_ipv6_80 "
  security_group_id = aws_security_group.sg_bastion.id

  cidr_ipv6   = "::/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

resource "aws_vpc_security_group_egress_rule" "egress_ipv4_80" {
  description       = "egress_ipv4_80"
  security_group_id = aws_security_group.sg_bastion.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

resource "aws_vpc_security_group_egress_rule" "egress_ipv6_443" {
  description       = "egress_ipv6_443"
  security_group_id = aws_security_group.sg_bastion.id

  cidr_ipv6   = "::/0"
  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

resource "aws_vpc_security_group_egress_rule" "egress_ipv4_443" {
  description       = "egress_ipv4_443"
  security_group_id = aws_security_group.sg_bastion.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

resource "aws_vpc_security_group_egress_rule" "egress_ipv6_icmp" {
  description       = "egress_ipv6_icmp"
  security_group_id = aws_security_group.sg_bastion.id

  cidr_ipv6   = "::/0"
  ip_protocol = "icmpv6"
  from_port   = -1
  to_port     = -1

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

resource "aws_vpc_security_group_egress_rule" "egress_ipv4_icmp" {
  description       = "egress_ipv4_icmp"
  security_group_id = aws_security_group.sg_bastion.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "icmp"
  from_port   = -1
  to_port     = -1

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

resource "aws_vpc_security_group_egress_rule" "egress_ssh_kub_sg" {
  description       = "egress_ssh_kub_sg"
  security_group_id = aws_security_group.sg_bastion.id

  referenced_security_group_id = var.sg_kub_workers_id
  ip_protocol                  = "tcp"
  from_port                    = 22
  to_port                      = 22

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}









