resource "aws_network_acl" "bastion" {
  vpc_id = aws_vpc.kubernetes.id
  # See below for aws_network_acl_association
  # subnet_ids = [aws_subnet.sn_bastion.id]

  # Although we have security groups in place, having these NACLs
  # provides and extra level of security


  ########## ALLOW INGRESS RULES ##########

  # Allow SSH from remote client with specific ipv6 address
  ingress {
    rule_no         = 100
    action          = "allow"
    ipv6_cidr_block = var.ingress_ip_v6
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
  }

  # Allow SSH from remote client with specific ipv4 address
  # UNCOMMENT FOR IPV4
  # ingress {
  #   rule_no    = 110
  #   action     = "allow"
  #   cidr_block = var.ingress_ip_v4
  #   protocol   = "tcp"
  #   from_port  = 22
  #   to_port    = 22
  # }

  # Allow icmp from anywhere ipv4
  ingress {
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "icmp"
    icmp_type  = "-1"
    icmp_code  = "-1"
    from_port  = 0
    to_port    = 0
  }

  # Allow icmp from anywhere ipv6
  ingress {
    rule_no         = 130
    action          = "allow"
    ipv6_cidr_block = "::/0"
    protocol        = "ipv6-icmp" # (58)
    icmp_type       = "-1"
    icmp_code       = "-1"
    from_port       = 0
    to_port         = 0
  }

  # Allow icmp from kube workers
  # Not really necessary but it show how to set this rule
  ingress {
    rule_no    = 140
    action     = "allow"
    cidr_block = var.cidr_kube_workers
    protocol   = "icmp"
    icmp_type  = "-1"
    icmp_code  = "-1"
    from_port  = 0
    to_port    = 0
  }

  # Allow ephemeral ports ipv4 from anywhere
  # This is useful for downloading updates.
  ingress {
    rule_no    = 150
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
  }

  # Allow ephemeral ports ipv6 from anywhere
  # This is useful for downloading updates.
  ingress {
    rule_no         = 160
    action          = "allow"
    ipv6_cidr_block = "::/0"
    protocol        = "tcp"
    from_port       = 1024
    to_port         = 65535
  }

  # Allow port 80 from kub workers subnet
  # The route for kub workers goes through the
  # bastion gateway.
  # So port 80 needs to be open to kub workers to make
  # an outbound connection
  ingress {
    rule_no    = 170
    action     = "allow"
    cidr_block = var.cidr_kube_workers
    protocol   = "tcp"
    from_port  = 80
    to_port    = 80
  }

  ########## ALLOW EGRESS RULES ##########

  # Allow ipv4 pings to anywhere
  egress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "icmp"
    icmp_type  = "-1"
    icmp_code  = "-1"
    from_port  = 0
    to_port    = 0
  }

  # Allow ipv6 pings to anywhere
  egress {
    rule_no         = 110
    action          = "allow"
    ipv6_cidr_block = "::/0"
    protocol        = "ipv6-icmp" # (58)
    icmp_type       = "-1"
    icmp_code       = "-1"
    from_port       = 0
    to_port         = 0
  }

  # Allow ssh (ipv4) to anywhere
  egress {
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "tcp"
    from_port  = 22
    to_port    = 22
  }

  # Allow ssh (ipv6) to anywhere
  egress {
    rule_no         = 130
    action          = "allow"
    ipv6_cidr_block = "::/0"
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
  }

  # Allow port 80 (ipv4) to download updates
  egress {
    rule_no    = 140
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "tcp"
    from_port  = 80
    to_port    = 80
  }

  # Allow port 80 (ipv6) to download updates
  egress {
    rule_no         = 150
    action          = "allow"
    ipv6_cidr_block = "::/0"
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
  }

  # Allow ephemeral ports ipv4 to anywhere
  egress {
    rule_no    = 160
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
  }

  # Allow ephemeral ports ipv6 to anywhere
  egress {
    rule_no         = 170
    action          = "allow"
    ipv6_cidr_block = "::/0"
    protocol        = "tcp"
    from_port       = 1024
    to_port         = 65535
  }

  ########## DENY INGRESS RULES ##########
  #    DENY ALL is set automatically for ingress rules for customer NACLs

  ########## DENY EGRESS RULES ##########
  #    NONE

  tags = {
    Name = "${var.project_name} bastion"
  }
}



resource "aws_network_acl" "kub_workers" {
  vpc_id = aws_vpc.kubernetes.id
  # See below for aws_network_acl_association
  # subnet_ids = [aws_subnet.sn_kub_workers.id]

  ########## ALLOW INGRESS RULES ##########

  # Allow icmp ipv4 in from bastion subnet
  ingress {
    rule_no    = 100
    action     = "allow"
    cidr_block = var.cidr_bastion
    protocol   = "icmp"
    icmp_type  = "-1"
    icmp_code  = "-1"
    from_port  = 0
    to_port    = 0
  }

  # Allow ssh in from bastion subnet
  ingress {
    rule_no    = 110
    action     = "allow"
    cidr_block = var.cidr_bastion
    protocol   = "tcp"
    from_port  = 22
    to_port    = 22
  }


  # Allow icmp (ipv4) in from anywhere
  ingress {
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "icmp"
    icmp_type  = "-1"
    icmp_code  = "-1"
    from_port  = 0
    to_port    = 0
  }

  # Allow icmp (ipv4) in from anywhere
  ingress {
    rule_no         = 130
    action          = "allow"
    ipv6_cidr_block = "::/0"
    protocol        = "ipv6-icmp"
    icmp_type       = "-1"
    icmp_code       = "-1"
    from_port       = 0
    to_port         = 0
  }

  # Allow ephemeral ports ipv4 from anywhere
  # This is useful for downloading updates.
  ingress {
    rule_no    = 140
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
  }

  # Allow ephemeral ports ipv6 from anywhere
  # This is useful for downloading updates.
  ingress {
    rule_no         = 150
    action          = "allow"
    ipv6_cidr_block = "::/0"
    protocol        = "tcp"
    from_port       = 1024
    to_port         = 65535
  }

  ########## ALLOW EGRESS RULES ##########

  # Allow ipv4 pings to anywhere
  egress {
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "icmp"
    icmp_type  = "-1"
    icmp_code  = "-1"
    from_port  = 0
    to_port    = 0
  }

  # Allow ipv6 pings to anywhere
  egress {
    rule_no         = 210
    action          = "allow"
    ipv6_cidr_block = "::/0"
    protocol        = "ipv6-icmp" # (58)
    icmp_type       = "-1"
    icmp_code       = "-1"
    from_port       = 0
    to_port         = 0
  }

  # Allow port 80 (ipv4) to download updates
  egress {
    rule_no    = 220
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "tcp"
    from_port  = 80
    to_port    = 80
  }

  # Allow port 80 (ipv6) to download updates
  egress {
    rule_no         = 230
    action          = "allow"
    ipv6_cidr_block = "::/0"
    protocol        = "tcp"
    from_port       = 80
    to_port         = 80
  }

  # Allow ephemeral port ipv4 to anywhere
  egress {
    rule_no    = 240
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
  }

  # Allow ephemeral port ipv6 to anywhere
  egress {
    rule_no         = 250
    action          = "allow"
    ipv6_cidr_block = "::/0"
    protocol        = "tcp"
    from_port       = 1024
    to_port         = 65535
  }

  ########## DENY INGRESS RULES ##########
  #    DENY ALL is set automatically for ingress rules for customer NACLs

  ########## DENY EGRESS RULES ##########
  #    NONE


  tags = {
    Name = "${var.project_name} kub workers"
  }
}

# This is here to make the association.
# This is probably the better way of doing this as the network ACL can
# stand alone.
resource "aws_network_acl_association" "bastion" {
  network_acl_id = aws_network_acl.bastion.id
  subnet_id      = aws_subnet.sn_bastion.id
}

resource "aws_network_acl_association" "kub_workers" {
  network_acl_id = aws_network_acl.kub_workers.id
  subnet_id      = aws_subnet.sn_kub_workers.id
}
