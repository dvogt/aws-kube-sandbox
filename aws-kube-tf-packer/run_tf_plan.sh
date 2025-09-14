#!/usr/bin/env sh

terraform plan \
   -var-file="../aws-kube-shared/packer.tfvars" 