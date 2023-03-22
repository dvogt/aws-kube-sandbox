


# resource "aws_security_group" "sg_load_balancer" {
#   name   = "loadbalancer_sec_group"
#   vpc_id = aws_vpc.kubernetes.id

#   # SSH access from anywhere
#   # ingress {
#   #   description = "SSH from VPC"
#   #   from_port   = 22
#   #   to_port     = 22
#   #   protocol    = "tcp"
#   #   # ipv6_cidr_blocks = ["${var.ingress_ip_v6}"]
#   #   ipv6_cidr_blocks = ["::/0"]
#   # }

#   # SSH access from anywhere
#   ingress {
#     description = "SSH from my computer ipv4"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     # security_groups = [var.sg_bastion]
#     # ipv6_cidr_blocks = ["${var.ingress_ip_v6}"]
#     cidr_blocks = [var.myip]
#   }

#   # ingress {
#   #   description = "HTTP from anywhere ipv4"
#   #   from_port   = 80
#   #   to_port     = 80
#   #   protocol    = "tcp"
#   #   cidr_blocks = ["0.0.0.0/0"]
#   # }

#   # ingress {
#   #   description      = "HTTP from anywhere ipv6"
#   #   from_port        = 80
#   #   to_port          = 80
#   #   protocol         = "tcp"
#   #   ipv6_cidr_blocks = ["::/0"]
#   # }


#   # ingress {
#   #   description = "HTTPS from anywhere ipv4"
#   #   from_port   = 443
#   #   to_port     = 443
#   #   protocol    = "tcp"
#   #   # security_groups = [var.sg_bastion]
#   #   # ipv6_cidr_blocks = ["${var.ingress_ip_v6}"]
#   #   cidr_blocks = ["0.0.0.0/0"]
#   # }

#   # ingress {
#   #   description      = "HTTPS from anywhere ipv6"
#   #   from_port        = 443
#   #   to_port          = 443
#   #   protocol         = "tcp"
#   #   ipv6_cidr_blocks = ["::/0"]
#   # }


#   ingress {
#     description = "icmp from my computer ipv4"
#     from_port   = -1
#     to_port     = -1
#     protocol    = "icmp"
#     cidr_blocks = [var.myip]
#     # cidr_blocks = ["0.0.0.0/0"]
#   }



#   # outbound internet access
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = var.project_name
#   }
# }
