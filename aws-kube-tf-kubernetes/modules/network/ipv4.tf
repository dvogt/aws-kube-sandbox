
# USE if you need NAT Gateway for IPv4

# # Elastic IP resource
# resource "aws_eip" "sn_nat_eip" {
#   domain = "vpc"
# }

# resource "aws_nat_gateway" "sn_nat_gw" {
#   allocation_id = aws_eip.sn_nat_eip.id
#   subnet_id     = aws_subnet.sn_bastion.id
#   tags = {
#     Name = var.project_name
#   }
# }

# Add IPv4 route for Kube subnet to NAT gateway
# resource "aws_route" "to_nat" {
#   # https://github.com/hashicorp/terraform-provider-aws/issues/1426
#   route_table_id         = aws_route_table.to_eigw_and_nat.id
#   nat_gateway_id         = aws_nat_gateway.sn_nat_gw.id
#   destination_cidr_block = "0.0.0.0/0"
# }

