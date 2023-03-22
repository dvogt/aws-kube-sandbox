
## Use Terraform to create VPC to build packer images

1. use IPv6 https://github.com/dvogt/aws-cube/README.md#about-ipv6-in-this-environment
2. `cd aws-kube-tf-packer/`
3. **Run:** `tf init`
4. **Run:** `tf plan`
4. **Run:** tf appply
5. Get the `vpc_id` and `subnet_id` from AWS for Packer VPC in AWS
6. Continue the instuctions for in: https://github.com/dvogt/aws-cube/aws-kube-ansible-builds/README.md#Build with Packer and store the iamges on AWS
7. **Run:** `tf destory` # You don't want this VPC running unless you are building AMIs
