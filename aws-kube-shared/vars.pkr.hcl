# There should be no need to change these variables.

# Name of Project. 
# This is used to find the VPC, subnet and security groups built by terraform
# If you change the project name here, you will need to change the project_name variable  
# in the aws-kube-tf-packer/variables.tf file as well.
project_name = "aws-kube-packer"

# Ubuntu owner id 
aws_ami_owner_id = ["099720109477"]

ssh_username = "ubuntu"

# AMI Image to pull from is the name of the image. 
# This image may be in different regions but will have differfent AMI IDs
# ami_image_to_pull_from = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
ami_image_to_pull_from = "ubuntu/images/hvm-ssd/ubuntu-noble-24.04-amd64-server-*"

# Region where the image will be built
region = "us-east-1"

# The list of regions to copy the AMI to
ami_regions = ["us-east-1"]
#default = ["us-east-1", "us-west-2"]

# The EC2 instance type to use while building the AMI
instance_type = "t2.medium"
