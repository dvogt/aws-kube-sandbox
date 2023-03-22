
# Elastic IP resource
resource "aws_eip" "sn_nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "sn_nat_gw" {
  allocation_id = aws_eip.sn_nat_eip.id
  subnet_id     = aws_subnet.sn_bastion.id
  tags = {
    Name = var.project_name
  }
}
