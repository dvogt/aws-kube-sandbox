#!/usr/bin/env sh

terraform destroy \
   -var-file="../aws-kube-shared/packer.tfvars" 