
# Create a VPC to launch our instances into
resource "aws_vpc" "kubernetes" {
  assign_generated_ipv6_cidr_block = true
  cidr_block                       = var.vpc_cidr

  # ENPOINT fix
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}"
  }
}
