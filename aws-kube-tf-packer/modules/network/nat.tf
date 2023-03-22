

resource "aws_eip" "sn_nat" {
  vpc = true
}

resource "aws_nat_gateway" "sn_nat" {
  allocation_id = aws_eip.sn_nat.id
  subnet_id     = aws_subnet.sn_packer.id

  tags = {
    Name = var.project_name
  }
}

