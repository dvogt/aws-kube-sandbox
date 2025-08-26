#!/usr/bin/env bash


set -euo pipefail

# Wait for kubeadm init to complete (admin.conf present)
# for i in {1..60}; do
#   [[ -f /etc/kubernetes/admin.conf ]] && break
#   sleep 5
# done

# If not initialized yet, initialize control-plane (adjust CIDR as needed)
if [[ ! -f /etc/kubernetes/admin.conf ]]; then
  echo "[ctl] running kubeadm init"
  # sudo kubeadm init --pod-network-cidr ${pod_cidr}
  sudo kubeadm init --pod-network-cidr {{ kube_pod_cidr }} --kubernetes-version {{ kube_adm_version }}
  
  # Copy config file so kubctl can run as ubuntu user
  sudo cp -i /etc/kubernetes/admin.conf /home/ubuntu/.kube/config
  sudo chown ubuntu:ubuntu /home/ubuntu/.kube/config
fi

# Create/print a join command (24h TTL by default; change with --ttl)
JOIN="$(sudo kubeadm token create --print-join-command)"

# Resolve region from IMDSv2
TOKEN="$(curl -sS -X PUT 'http://169.254.169.254/latest/api/token' -H 'X-aws-ec2-metadata-token-ttl-seconds: 300')"
REGION="$(curl -sS -H "X-aws-ec2-metadata-token: ${TOKEN}" http://169.254.169.254/latest/meta-data/placement/region)"

#!/bin/sh

echo "[ctl] writing join to SSM {{ k8s_param_join }}"

# Set the maximum number of retries and the delay between attempts
MAX_RETRIES=60
DELAY=5
RETRIES=0

while [ $RETRIES -lt $MAX_RETRIES ]; do
  # Attempt to write the parameter to SSM
  aws ssm put-parameter \
    --region "${REGION}" \
    --name "{{ k8s_param_join }}" \
    --type String \
    --value "${JOIN}" \
    --overwrite

  # Check if the command succeeded
  if [ $? -eq 0 ]; then
    echo "Successfully wrote to SSM."
    break
  else
    echo "Failed to write to SSM. Attempt $((RETRIES + 1)) of $MAX_RETRIES."
    RETRIES=$((RETRIES + 1))
    sleep $DELAY
  fi
done

if [ $RETRIES -eq $MAX_RETRIES ]; then
  echo "Failed to write to SSM after $MAX_RETRIES attempts."
  exit 1
fi

