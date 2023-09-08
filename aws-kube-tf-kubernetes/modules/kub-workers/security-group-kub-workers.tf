

resource "aws_security_group" "sg_kub_workers" {
  name        = "sg_kub_workers"
  description = "${var.project_name} ${var.module_name}"
  vpc_id      = var.aws_vpc_id

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}


########################################################################
########################## INGRESS RULES ###############################
########################################################################

resource "aws_vpc_security_group_ingress_rule" "ingress_ssh_bastion_sg" {
  description       = "ingress_ssh_bastion_sg"
  security_group_id = aws_security_group.sg_kub_workers.id

  referenced_security_group_id = var.sg_bastion_id
  ip_protocol                  = "tcp"
  from_port                    = 22
  to_port                      = 22

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_icmp_bastion_sg" {
  description       = "ingress_icmp_bastion_sg"
  security_group_id = aws_security_group.sg_kub_workers.id

  referenced_security_group_id = var.sg_bastion_id
  ip_protocol                  = "icmp"
  from_port                    = -1
  to_port                      = -1

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_all_kub_sg" {
  description       = "ingress_all_kub_sg"
  security_group_id = aws_security_group.sg_kub_workers.id

  referenced_security_group_id = aws_security_group.sg_kub_workers.id
  ip_protocol                  = -1

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}


########################################################################
########################## EGRESS RULES#################################
########################################################################


resource "aws_vpc_security_group_egress_rule" "egress_ipv6_80" {
  description       = "egress_ipv6_80 "
  security_group_id = aws_security_group.sg_kub_workers.id

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
  security_group_id = aws_security_group.sg_kub_workers.id

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
  security_group_id = aws_security_group.sg_kub_workers.id

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
  security_group_id = aws_security_group.sg_kub_workers.id

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
  security_group_id = aws_security_group.sg_kub_workers.id

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
  security_group_id = aws_security_group.sg_kub_workers.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "icmp"
  from_port   = -1
  to_port     = -1

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

resource "aws_vpc_security_group_egress_rule" "egress_all_kub_sg" {
  description       = "egress_all_kub_sg"
  security_group_id = aws_security_group.sg_kub_workers.id

  referenced_security_group_id = aws_security_group.sg_kub_workers.id
  ip_protocol                  = "-1"

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

# resource "aws_vpc_security_group_egress_rule" "egress_ipv4_all" {
#   description       = "egress_ipv4_all"
#   security_group_id = aws_security_group.sg_kub_workers.id

#   cidr_ipv4   = "0.0.0.0/0"
#   ip_protocol = "-1"

#   tags = {
#     Name = "${var.project_name} ${var.module_name}"
#   }
# }

# resource "aws_vpc_security_group_egress_rule" "egress_ipv6_all" {
#   description       = "egress_ipv6_all"
#   security_group_id = aws_security_group.sg_kub_workers.id

#   cidr_ipv6   = "::/0"
#   ip_protocol = "-1"

#   tags = {
#     Name = "${var.project_name} ${var.module_name}"
#   }
# }


