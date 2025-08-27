
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
1. On the **kube controller** run `kubectl get nodes` to verify you nodes are have joined and are ready.
1. Play in your new sandbox
   * 10.0.5.10 is the Kubernetes Controller
   *  on up are your workers
1. After using the sandox **run:** `tf destory` # This will save you a fair amount of money

**Notes:**

* The `./kubeadm.sh` and `calico.sh` scripts are run automatically on the Controller node. 
* The Controller node will save the join command to the SSM Parameter Store.
* The Worker nodes will grab the join command from the Parameter store and automatically join the join the cluster. 
* The token in the join command is only good for 24 hours after the Controller node is provisioned.   