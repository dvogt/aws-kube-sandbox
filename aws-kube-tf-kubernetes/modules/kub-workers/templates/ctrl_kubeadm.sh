#!/usr/bin/env bash
set -euo pipefail


RETRIES=${retries}           # from Terraform
MAX_RETRIES=${max_retries}   # from Terraform
SLEEP=${sleep}               # from Terraform
AWS_REGION="${aws_region}"   # from Terraform
K8S_SSM_JOIN="${k8s_ssm_join}"  # from Terraform

for i in {1..10}; do
  if [ -f /home/ubuntu/kubeadm.yaml ]; then
    echo "kubeadm.yaml exists."
    break
  fi
  echo "Waiting for kubeadm.yaml to be created..."
  sleep 15
done

# If not initialized yet, initialize control-plane (adjust CIDR as needed)
if [[ ! -f /etc/kubernetes/admin.conf ]]; then
  echo "[ctl] running kubeadm init"
  sudo kubeadm init  --config /home/ubuntu/kubeadm.yaml

  # Copy config file so kubctl can run as ubuntu user
  sudo cp -i /etc/kubernetes/admin.conf /home/ubuntu/.kube/config
  sudo chown ubuntu:ubuntu /home/ubuntu/.kube/config
fi

# Create/print a join command (24h TTL by default; change with --ttl)
JOIN="$(sudo kubeadm token create --print-join-command)"

echo "[ctl] writing join to SSM $K8S_SSM_JOIN"
while [ "$RETRIES" -lt "$MAX_RETRIES" ]; do
  # Attempt to write the parameter to SSM
  aws ssm put-parameter \
    --region "$AWS_REGION" \
    --name "$K8S_SSM_JOIN" \
    --type String \
    --value "$JOIN" \
    --overwrite

  # Check if the command succeeded
  if [ $? -eq 0 ]; then
    echo "Successfully wrote join to SSM."
    break
  else
    echo "Failed to write join to SSM. Attempt $((RETRIES + 1)) of $MAX_RETRIES."
    RETRIES=$((RETRIES + 1))
    sleep $SLEEP
  fi
done

if [ $RETRIES -eq $MAX_RETRIES ]; then
  echo "Failed to write to join command to SSM after $MAX_RETRIES attempts."
  exit 1
fi
