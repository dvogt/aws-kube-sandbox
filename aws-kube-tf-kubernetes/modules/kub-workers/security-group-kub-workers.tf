



resource "aws_security_group" "sg_kub_workers" {
  name        = "sg_kub_workers"
  description = "${var.project_name} ${var.module_name}"
  vpc_id      = var.aws_vpc_id

  # SSH access from bastion security groups
  ingress {
    description     = "SSH from bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [var.bastion_security_groups]
  }


  # CMP access from bastion security groups
  ingress {
    description     = "icmp from bastion"
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    security_groups = [var.bastion_security_groups]
  }

  # Allow all ports open in current security group
  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  # outbound internet access
  egress {
    from_port        = 0
    to_port          = 443
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  # outbound internet access
  egress {
    from_port        = -1
    to_port          = -1
    protocol         = "icmpv6"
    ipv6_cidr_blocks = ["::/0"]
  }

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
    Name = "${var.project_name} ${var.module_name}"
  }
}

#

