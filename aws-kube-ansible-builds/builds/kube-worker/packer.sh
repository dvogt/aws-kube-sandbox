#!/bin/sh

# The packer command to run.
packer build -var-file="../../../aws-kube-shared/vars.pkr.hcl" aws-ubuntu-kube-worker.pkr.hcl
