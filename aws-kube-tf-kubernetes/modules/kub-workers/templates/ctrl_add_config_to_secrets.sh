
echo "[ctl] writing admin to k8s_secrets_config becaus it is over 4K"

CONFIG_RETRIES=${retries}        # from Terraform
CONFIG_MAX_RETRIES=${max_retries}   # from Terraform
CONFIG_SLEEP=${sleep}               # from Terraform
AWS_REGION="${aws_region}"   # from Terraform
K8S_SECRETS_CONFIG="${k8s_secrets_config}"  # from Terraform


while [ $CONFIG_RETRIES -lt $CONFIG_MAX_RETRIES ]; do
  # Attempt to write the parameter to secrets manager
  aws secretsmanager put-secret-value \
  --region "$AWS_REGION" \
  --secret-id  "$K8S_SECRETS_CONFIG"  \
  --secret-string file:///home/ubuntu/.kube/config 

  # Check if the command succeeded
  if [ $? -eq 0 ]; then
    echo "Successfully wrote K8S config to Secrets Manager."
    break
  else
    echo "Failed to write K8S config to Secrets Manager. Attempt $((CONFIG_RETRIES + 1)) of $CONFIG_MAX_RETRIES."
    CONFIG_RETRIES=$((CONFIG_RETRIES + 1))
    sleep $CONFIG_SLEEP
  fi
done

if [ $CONFIG_RETRIES -eq $CONFIG_MAX_RETRIES ]; then
  echo "Failed to write K8S config to Secrest Manager after $CONFIG_MAX_RETRIES attempts."
  exit 1
fi



