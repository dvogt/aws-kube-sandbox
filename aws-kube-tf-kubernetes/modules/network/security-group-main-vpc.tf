
# Our default security group Deny all and use bastion security group
# This can't be deleted so we prevent all ingress to the default group
# the instances over SSH and HTTP

# DON'T REMOVE
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.kubernetes.id

  # ingress {
  #   protocol  = -1
  #   self      = true
  #   from_port = 0
  #   to_port   = 0
  # }

  # egress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  tags = {
    Name = "${var.project_name} default"
  }
}
