

########################################################################
############# Security Group rules for Workers/Controlers ##############
########################################################################

resource "aws_security_group" "sg_kub_workers" {
  name        = "sg_kub_workers"
  description = "${var.project_name} ${var.module_name}"
  vpc_id      = var.aws_vpc_id

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

resource "aws_security_group" "sg_kub_controller" {
  name        = "sg_kub_controller"
  description = "${var.project_name} ${var.module_name}"
  vpc_id      = var.aws_vpc_id

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

############# Ingress Rule for API from Client ########################

# Allow client to use the Kubernetes API using kubectl, etc.
resource "aws_vpc_security_group_ingress_rule" "ingress_ipv6_api_client" {
  description       = "Access K8S API on controller from your client"
  security_group_id = aws_security_group.sg_kub_controller.id

  cidr_ipv6   = var.ingress_ip_v6
  ip_protocol = "tcp"
  from_port   = 6443
  to_port     = 6443

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

############# Ingress Rules for Workers/Controlers #####################

# Use this for debugging only
resource "aws_vpc_security_group_ingress_rule" "ingress_all_kub_sg" {
  description       = "ingress_all_kub_sg"
  security_group_id = aws_security_group.sg_kub_workers.id
  referenced_security_group_id = aws_security_group.sg_kub_workers.id

  ip_protocol                  = -1
  
  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

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



resource "aws_vpc_security_group_ingress_rule" "ingress_ipv4_443" {
  description       = "ingress_ipv4_443"
  security_group_id = aws_security_group.sg_kub_workers.id

  cidr_ipv4   = var.sn_kub_workers.cidr_block
  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_ipv6_443" {
  description       = "ingress_ipv6_443"
  security_group_id = aws_security_group.sg_kub_workers.id


  cidr_ipv6   = var.sn_kub_workers.ipv6_cidr_block
  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}




############# Egress Rules for Workers/Controlers #####################

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


#####################################################
##### Security Group for pulling docker images ######
#####################################################

# # Security group that the VPC endpoints will use
# resource "aws_security_group" "vpce" {
#   name        = "${var.project_name}-vpce"
#   description = "TLS from node subnet to interface endpoints"
#   vpc_id      = var.aws_vpc_id

#   tags = { Name = "${var.project_name}-vpce" }
# }

############### Ingress Rules for pulling docker images #############

# resource "aws_vpc_security_group_ingress_rule" "vpce_ingress_ipv4_443" {
#   description       = "vpce_ingress_ipv4_443"
#   security_group_id = aws_security_group.vpce.id

#   cidr_ipv4   = var.sn_kub_workers.cidr_block
#   ip_protocol = "tcp"
#   from_port   = 443
#   to_port     = 443

#   tags = {
#     Name = "${var.project_name} ${var.module_name}"
#   }
# }


# resource "aws_vpc_security_group_ingress_rule" "vpce_ingress_ipv6_443" {
#   description       = "vpce_ingress_ipv6_443"
#   security_group_id = aws_security_group.vpce.id

#   cidr_ipv6   = var.sn_kub_workers.ipv6_cidr_block
#   ip_protocol = "tcp"
#   from_port   = 443
#   to_port     = 443

#   tags = {
#     Name = "${var.project_name} ${var.module_name}"
#   }
# }

############ Egress Rules for pulling docker images ################

# resource "aws_vpc_security_group_egress_rule" "vpce_egress_ipv4_icmp" {
#   description       = "vpce_egress_ipv4_icmp"
#   security_group_id = aws_security_group.vpce.id

#   cidr_ipv4   = "0.0.0.0/0"
#   ip_protocol = "icmp"
#   from_port   = -1
#   to_port     = -1

#   tags = {
#     Name = "${var.project_name} ${var.module_name}"
#   }
#}

# resource "aws_vpc_security_group_egress_rule" "vpce_egress_ipv6_icmp" {
#   description       = "vpce_egress_ipv6_icmp"
#   security_group_id = aws_security_group.vpce.id

#   cidr_ipv6   = "::/0"
#   ip_protocol = "icmpv6"
#   from_port   = -1
#   to_port     = -1

#   tags = {
#     Name = "${var.project_name} ${var.module_name}"
#   }
# }
