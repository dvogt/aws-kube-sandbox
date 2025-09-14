output "aws_internet_gateway" {
  value = aws_internet_gateway.internet_gateway.id
}

output "aws_vpc_id" {
  value = aws_vpc.kubernetes.id
}

output "ipv6_cidr_block" {
  value = aws_vpc.kubernetes.assign_generated_ipv6_cidr_block
}

output "sn_bastion" {
  value = aws_subnet.sn_bastion.id
}

output "sn_kub_workers" {
  value = aws_subnet.sn_kub_workers
}

output "route_table" {
  value = aws_route_table.public_rt
}