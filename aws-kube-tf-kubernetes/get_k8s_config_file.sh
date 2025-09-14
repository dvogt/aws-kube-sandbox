#!/usr/bin/env sh

# If you are not using us-east change the region below.

aws secretsmanager get-secret-value \
  --region us-east-1 \
  --secret-id "k8s-config" \
  --query SecretString --output text > ~/.kube/config
