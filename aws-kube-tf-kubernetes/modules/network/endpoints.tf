# resource "aws_security_group" "vpce_ssm_sg" {
#   name        = "vpce-ssm-sg"
#   description = "Allow HTTPS from instances"
#   vpc_id      = var.vpc_id

#   ingress {
#     from_port       = 443
#     to_port         = 443
#     protocol        = "tcp"
#     security_groups = [var.instance_sg_id]  # allow from instance SG
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

