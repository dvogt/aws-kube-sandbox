#!/usr/bin/env bash

RETRIES=${retries}           # From Terraform, default to 0 if not set
MAX_RETRIES=${max_retries}   # From Terraform, default to 5 if not set
SLEEP=${sleep}               # From Terraform, default to 5 seconds if not set
AWS_REGION="${aws_region}"       # From Terraform
K8S_SSM_JOIN="${k8s_ssm_join}"   # From Terraform
JOIN=""

echo "[worker] waiting for join command in SSM $K8S_SSM_JOIN"

# Retrieving the join command with retries
get_join_command() {
    aws ssm get-parameter \
        --region "$AWS_REGION" \
        --name "$K8S_SSM_JOIN" \
        --query 'Parameter.Value' \
        --output text 2>/dev/null || return 1
}


# Retry until we hit MAX_RETRIES or get a valid kubeadm join command
while (( RETRIES < MAX_RETRIES )); do
    JOIN=$(get_join_command || echo "")

    if [[ -n "$JOIN" && "$JOIN" == kubeadm\ join* ]]; then
        echo "Successfully retrieved join command: $JOIN"
        break
    fi

    echo "Join command not available or invalid (Attempt $((RETRIES + 1)) of $MAX_RETRIES)"
    (( RETRIES++ ))
    sleep "$SLEEP"
done

if (( RETRIES >= MAX_RETRIES )) && [[ "$JOIN" != kubeadm\ join* ]]; then
    echo "Exceeded maximum retry attempts without a valid join command. Exiting..."
    exit 1
fi

echo "[worker] executing: $JOIN"

# Attempt to execute the join command with retries
for attempt in $(seq 1 "$MAX_RETRIES"); do
    if sudo $JOIN; then
        exit 0  # Exit successfully if command executes
    else
        echo "[worker] attempt $attempt failed, retrying..."
        sleep "$SLEEP"  # Wait before retrying
    fi
done

echo "[worker] failed to execute join command after multiple attempts" >&2

exit 1  # Exit with an error if all execution attempts fail
