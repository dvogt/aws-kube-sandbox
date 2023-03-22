#!/bin/sh

# Run as ubuntu user

kubectl get nodes

kubectl apply -f /home/ubuntu/calico.yaml

kubectl get nodes

kubeadm token create --print-join-command
