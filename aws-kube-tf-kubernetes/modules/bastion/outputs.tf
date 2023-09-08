
# output "bastion_public_ip" {
#   value = aws_instance.bastion.public_ip
# }

output "bastion_private_ip" {
  value = aws_instance.bastion.private_ip
}

output "bastion_ipv6" {
  value = aws_instance.bastion.ipv6_addresses
}

output "sg_bastion_id" {
  value = aws_security_group.sg_bastion.id
}
