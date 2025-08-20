

# Only needed for ipv4
# UNCOMMENT FOR IPV4
# resource "aws_eip" "bastion" {
#   vpc = true
# }
# resource "aws_eip_association" "bastion" {
#   instance_id   = aws_instance.bastion.id
#   allocation_id = aws_eip.bastion.id
# }


resource "aws_instance" "bastion" {

  disable_api_termination = var.bastion_disable_api_termination
  ipv6_address_count      = 1
  instance_type           = var.bastion_instance_type

  ami = var.latest_ubuntu_ami

  # The name of our SSH keypair we created above.
  key_name = var.ssh_key

  # Our Security group to allow HTTP and SSH access
  # vpc_security_group_ids = [aws_security_group.sg_bastion.id, var.sg_load_balancer]
  vpc_security_group_ids = [aws_security_group.sg_bastion.id]

  # We're going to launch into the same subnet as our ELB. In a production
  # environment it's more common to have a separate private subnet for
  # backend instances.
  subnet_id = var.aws_subnet_bastion

  tags = {
    Name = "${var.project_name} ${var.module_name}"
    Type = "public"
  }

  timeouts {
    create = "15m"
    delete = "20m"
  }

}



