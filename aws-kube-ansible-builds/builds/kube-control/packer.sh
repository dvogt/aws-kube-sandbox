#!/bin/sh

packer build -var-file="../../../aws-kube-shared/vars.pkr.hcl" aws-ubuntu-kube-control.pkr.hcl
