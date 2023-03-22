
# Create a VPC to launch our instances into
resource "aws_vpc" "packer" {
  assign_generated_ipv6_cidr_block = true
  cidr_block                       = var.vpc_cidr

  tags = {
    Name = "${var.project_name}"
  }
}
