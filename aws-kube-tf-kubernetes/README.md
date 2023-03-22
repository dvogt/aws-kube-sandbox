
## Use Terraform to create VPC for your Kubernetes cluster

1. use IPv6 https://github.com/dvogt/aws-cube/README.md#about-ipv6-in-this-environment
1. `cd aws-kube-tf-kubernetes`
1. **Run:** `tf init`
1. **Run:** `tf plan`
1. **Run:** tf appply
1. Log in to the **bastion host** at
	* For example: `ssh -A ubuntu@<bastion_ipv6>`
1. From the **bastion host** log in to the **Kubernetes Controller**
    * For example: `ssh -A ubuntu@10.0.5.10`
    * **10.0.5.10** is the static IPv4 of the controller
1. As the ubuntu user run: `./kubeadm.sh`
   * Make sure it runs without errors
     * You should something like: `kubeadm join 10.0.2.15:6443 ...`
1. As the ubuntu user run: ./calico.sh
   * Make sure it runs without errors
     * You should something like: `kubeadm join 10.0.2.15:6443 ...`
1. Log on to Kubernetes workers from the bastion and run the `sudo kubeadm join ...` command provided by the `kubeadm init` command
1. On the **kube controller** run `kubectl get nodes` to verify you nodes are have joined and are ready.
1. Play in your new sandbox
   * 10.0.5.10 is the Kubernetes Controller
   *  on up are your workers
1. After using the sandox **run:** `tf destory` # This will save you a fair amount of money
