# https://stackoverflow.com/questions/74460639/packer-cant-pass-var-file-as-input-to-build

# Your AWS Account ID without dashes
aws_owner_id = [""]

# Your AWS VPC ID from provided by Terraform
vpc_id = ""

# Your AWS SUBNET in the AWS VPC provided by Terraform
# This is needed to open for packer to create a temporary security group
subnet_id = ""

# AMI Image to pull from is the name of the image. 
# This image may be in different regions but will have differfent AMI IDs
ami_image_to_pull_from = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"

# Region where the image will be built
region = "us-east-1"

# The list of regions to copy the AMI to
ami_regions = ["us-east-1"]
#default = ["us-east-1", "us-west-2"]

# The EC2 instance type to use while building the AMI
instance_type = "t2.medium"
