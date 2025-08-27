#!/usr/bin/env bash


set -euo pipefail

TOKEN="$(curl -sS -X PUT 'http://169.254.169.254/latest/api/token' -H 'X-aws-ec2-metadata-token-ttl-seconds: 300')"
REGION="$(curl -sS -H "X-aws-ec2-metadata-token: ${TOKEN}" http://169.254.169.254/latest/meta-data/placement/region)"

echo "[worker] waiting for join command in SSM {{ k8s_param_join }}"
for i in {1..120}; do
    if JOIN="$(aws ssm get-parameter --region "${REGION}" --name "{{ k8s_param_join }}" --query 'Parameter.Value' --output text 2>/dev/null)"; then
        if [[ "$JOIN" == kubeadm\ join* ]]; then
            echo "[worker] executing: $JOIN"
            # Attempt to execute the join command in a loop
            for attempt in {1..60}; do  # Set a limit on attempts
                if sudo $JOIN; then
                    exit 0  # Exit successfully if command executes
                else
                    echo "[worker] attempt $attempt failed, retrying..."
                    sleep 5  # Wait before retrying
                fi
            done
            echo "[worker] failed to execute join command after multiple attempts" >&2
            exit 1  # Exit with an error if all attempts fail
        fi
    fi
    sleep 5
done
echo "[worker] timed out waiting for join command" >&2
exit 1
