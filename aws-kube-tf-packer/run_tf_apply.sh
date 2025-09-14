#!/usr/bin/env sh

terraform apply \
   -var-file="../aws-kube-shared/packer.tfvars"
