
# Provides an EC2 key pair resource. 
# The key pair is used to control login access to EC2 instances.

resource "aws_key_pair" "terraform_pub_key" {
  key_name   = "aws_terraform"
  public_key = file(var.ami_public_key)

  tags = {
    Name = var.project_name
  }
}


