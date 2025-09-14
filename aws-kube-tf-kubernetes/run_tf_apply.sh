#!/usr/bin/env sh

terraform apply \
   -var-file="../aws-kube-shared/k8s.vars.user.tfvars" \
   -var-file="../aws-kube-shared/k8s.vars.general.tfvars" 