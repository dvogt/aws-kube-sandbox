
resource "aws_security_group" "sg_bastion" {
  name        = "sg_bastion"
  description = "${var.project_name} bastion"
  vpc_id      = var.aws_vpc_id

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
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    ipv6_cidr_blocks = [var.ingress_ip_v6]
  }

  ingress {
    description      = "ICMP from VPC ipv6"
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
    Name = "${var.project_name} bastion"
  }
}

#

