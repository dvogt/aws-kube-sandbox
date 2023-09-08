
# ========================================================================
# Security Group
# ========================================================================


# Our default security group Deny all and use packer security group
# This can't be deleted so we prevent all ingress to the default group
# the instances over SSH and HTTP

# Don't remove 
resource "aws_default_security_group" "packer" {
  vpc_id = aws_vpc.packer.id
  #name   = "aws-kube-packer-sg"

  ingress {
    description = "ICMP from VPC ipv4"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.ingress_ip_v4]
  }

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ingress_ip_v4]
  }

  ingress {
    description      = "SSH from your workstation IPv6"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    ipv6_cidr_blocks = [var.ingress_ip_v6]
  }

  ingress {
    description      = "ICMP from your workstation IPv6"
    from_port        = -1
    to_port          = -1
    protocol         = "icmpv6"
    ipv6_cidr_blocks = [var.ingress_ip_v6]
  }


  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project_name}"
    # Name = "aws-kube-packer"
  }
}

# ========================================================================
# Security Group Egress Rules
# ========================================================================



# resource "aws_security_group_rule" "sg_packer_egress_from_ipv6_to_internet_icmpv6" {
#   description       = "sg_packer_egress_from_ipv6_to_internet_icmpv6"
#   security_group_id = aws_default_security_group.packer.id
#   from_port         = -1
#   to_port           = -1
#   protocol          = "icmpv6"
#   type              = "egress"
#   ipv6_cidr_blocks  = ["::/0"]
# }

# resource "aws_security_group_rule" "sg_packer_egress_from_ipv4_to_internet_icmpv4" {
#   description       = "sg_packer_egress_from_ipv4_to_internet_icmpv4"
#   security_group_id = aws_default_security_group.packer.id
#   from_port         = -1
#   to_port           = -1
#   protocol          = "icmp"
#   type              = "egress"
#   cidr_blocks       = ["0.0.0.0/0"]
# }

# resource "aws_security_group_rule" "sg_packer_egress_from_ipv4_to_internet_443" {
#   description       = "sg_packer_egress_from_ipv4_to_internet_443"
#   security_group_id = aws_default_security_group.packer.id
#   from_port         = 443
#   to_port           = 443
#   protocol          = "tcp"
#   type              = "egress"
#   cidr_blocks       = ["0.0.0.0/0"]
# }

# resource "aws_security_group_rule" "sg_packer_egress_from_ipv4_to_internet_22" {
#   description       = "sg_packer_egress_from_ipv4_to_internet_22"
#   security_group_id = aws_default_security_group.packer.id
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   type              = "egress"
#   cidr_blocks       = ["0.0.0.0/0"]
# }

# resource "aws_security_group_rule" "sg_packer_egress_from_ipv4_to_internet_80" {
#   description       = "sg_packer_egress_from_ipv4_to_internet_80"
#   security_group_id = aws_default_security_group.packer.id
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   type              = "egress"
#   cidr_blocks       = ["0.0.0.0/0"]
# }


# resource "aws_security_group_rule" "sg_packer_egress_from_ipv6_to_internet_443" {
#   description       = "sg_packer_egress_from_ipv6_to_internet_443"
#   security_group_id = aws_default_security_group.packer.id
#   from_port         = 443
#   to_port           = 443
#   protocol          = "tcp"
#   type              = "egress"
#   ipv6_cidr_blocks  = ["::/0"]
# }


# # ========================================================================
# # Security Group Ingres Rules
# # ========================================================================

# resource "aws_security_group_rule" "sg_packer_ingress_22_from_packer" {
#   description       = "sg_packer_ingress_22"
#   security_group_id = aws_default_security_group.packer.id
#   from_port         = 22
#   to_port           = 22
#   protocol          = "tcp"
#   type              = "ingress"
#   #source_security_group_id = var.sg_bastion_id
# }


# resource "aws_security_group_rule" "sg_packer_ingress_icmp_from_VPC_ipv4" {
#   description       = "sg_packer_ingress_icmp_from_VPC_ipv4"
#   security_group_id = aws_default_security_group.packer.id
#   from_port         = -1
#   to_port           = -1
#   protocol          = "icmp"
#   type              = "ingress"
#   # source_security_group_id = var.sg_bastion_id
# }


