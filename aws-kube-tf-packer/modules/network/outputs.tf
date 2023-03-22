output "aws_internet_gateway" {
  value = aws_internet_gateway.packer_ig.id
}

output "aws_vpc_id" {
  value = aws_vpc.packer.id
}

output "ipv6_cidr_block" {
  value = aws_vpc.packer.assign_generated_ipv6_cidr_block
}

output "sn_packer_id" {
  value = aws_subnet.sn_packer.id
}

