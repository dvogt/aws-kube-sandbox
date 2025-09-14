
## Use Terraform to create VPC for your Kubernetes cluster

1. use IPv6 https://github.com/dvogt/aws-cube/README.md#about-ipv6-in-this-environment
1. Add DNS records in `aws-kube-shared/k8s.vars.user.tfvars`
   * ```controller_hosted_zone```
   * ```controller_r53_record```
1. `cd aws-kube-tf-kubernetes`
1. **Run:** `tf init`
1. **Run:** `./run_tf_plan`
   <br/>This points to the tfvars in `aws-kube-shared` directory.
1. **Run:** `./run_tf_apply`
   <br/>This points to the tfvars in `aws-kube-shared` directory.
1. Log in to the **bastion host** at
	* For example: `ssh -A ubuntu@<bastion_ipv6>`
1. From the **bastion host** log in to the **Kubernetes Controller**
    * For example: `ssh -A ubuntu@10.0.5.10`
    * **10.0.5.10** is the static IPv4 of the controller
1. On the **kube controller** run `kubectl get nodes` to verify you nodes are have joined and are ready.
1. Copy the .kube/config file to your laptop by running
   <br/>```get_k8s_config_file.sh```
   <br/>**Note:** you may have to wait a couple of minutes for the config file to show up.
1. Run ```kubectl get nodes``` from you laptop or the controller
1. Play in your new sandbox
   * 10.0.5.10 is the Kubernetes Controller
1. After using the sandox **run:** `./run_tf_apply` # This will save you a fair amount of money

**Notes:**

* The `./kubeadm.sh` and `calico.sh` scripts are run automatically on the Controller node. 
* The Controller node will save the join command to the SSM Parameter Store.
* The Worker nodes will grab the join command from the Parameter store and automatically join the join the cluster. 
* The token in the join command is only good for 24 hours after the Controller node is provisioned.   