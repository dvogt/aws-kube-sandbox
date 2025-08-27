for i in {1..120}; do
    if JOIN="$(aws ssm get-parameter --region "${REGION}" --name "{{ k8s_param_join }}" --query 'Parameter.Value' --output text 2>/dev/null)"; then
        if [[ "$JOIN" == kubeadm\ join* ]]; then
        echo "[worker] executing: $JOIN"
        # If you use a non-default CRI socket, append --cri-socket here.
        sudo $JOIN
        exit $?
        fi
    fi
    sleep 5
done