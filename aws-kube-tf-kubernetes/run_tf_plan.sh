#!/usr/bin/env sh

terraform plan \
   -var-file="../aws-kube-shared/k8s.vars.user.tfvars" \
   -var-file="../aws-kube-shared/k8s.vars.general.tfvars" 