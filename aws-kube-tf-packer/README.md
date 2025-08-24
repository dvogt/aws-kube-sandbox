
## Use Terraform to create VPC to build packer images


1. Enable [IPv6](https://github.com/dvogt/aws-kube-sandbox/tree/main?tab=readme-ov-file#about-ipv6-in-this-environment)
2. `cd aws-kube-tf-packer/`
3. **Run:** `terraform init`
4. **Run:** `terraform plan`
4. **Run:** `terraform appply`
5. Continue the instuctions for in: [Build with Packer and store on AWS](https://github.com/dvogt/aws-kube-sandbox/tree/main/aws-kube-ansible-builds#build-with-packer-and-store-on-aws) with Packer and store the images on AWS
7. **Run:** `tf destory` # You don't want this VPC running unless you are building AMIs
