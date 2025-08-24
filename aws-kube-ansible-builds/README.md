
# How to build the images for AWS

## Summary
This is used build the AMI images. \
Vagrant will ge the Ubuntu image and install the Kubernetes binaries for the workers and controllers. The binaries are installed using Ansible playbooks.

The best way to ensure repeatability is to build your own images.  \
The cost for storing images per month is less than one cup of coffee at your local BlueBucks coffee shop.

## Build Kubernetes cluster images locally with Vagrant for testing
   * cd to the build directory on your local system.
      * For example: `cd builds/kube-worker`
   * *Run:* `vagrant up`
   * Make sure there are no errors
   * If necessary ssh and debug Vagrant image: `vagrant ssh`
   * Make changes to the `roles/<build directory>`
   * If necessary rerun provision: `vagrant provision`

### Extra steps after building the Contorller node with Vagrant
1. `ssh vagrant`
2. As the ubuntu user run: `./kubeadm.sh`
   * Make sure it runs without errors
     * You should see something like: `kubeadm join 10.0.2.15:6443 ...`
3. As the ubuntu user run: ./calico.sh
   * Make sure it runs without errors
     * You should something like: `kubeadm join 10.0.2.15:6443 ...`

### Destroy the Vagrant box

Destroy the Vagrant box. The pupose was to make sure that Ansible would build correctly.
* `exit` from you vagrant box if you haven't already done so
* *Run:* `vagrant destroy`


## Build with Packer and store on AWS
   * Assuming that there were no error with the steps above, continue with the following steps.
   * [Create the Packer AWS VPC](https://github.com/dvogt/aws-kube-sandbox/blob/main/aws-kube-tf-packer/README.md)
   * Use the `vpc_id` and `subnet_id` and add them to the 
   * cd to the build folder you want to build in AWS
     * For example: `aws-kube-ansible-builds/builds/kube-control`
   * Run packer commands (optional but advised):
      * `packer init .`
      * `packer fmt .`
      * `packer validate .`
   * Run: `packer build -var-file="<var file name>" <package name>` 
      * *Example:* `packer build -var-file="../../../aws-kube-shared/vars.pkr.hcl" aws-ubuntu-kube-control.pkr.hcl`
      * **NOTE:** A `packer.sh` has been included in the directory to simplify this. 
         * *Run:* `./packer.sh`
   * **Reminder:** `cd` back to `aws-kube-tf-packer/` and run [`tf destory`](https://github.com/dvogt/aws-kube-sandbox/blob/main/aws-kube-tf-packer/README.md)

## Next Step

1. Follow the instructions at https://github.com/dvogt/aws-kube-sandbox/blob/main/aws-kube-tf-kubernetes/README.md


# Notes

* `kubeadm init` is run manually on the AWS instance after it has been deployed into your environment. This is is because the credentials are tied to the IP of the instances.
* `calico.sh` is run manully because it needs `kubeadmn init` to be run first. At the time of this writing it was difficult to know when kubeadmin was ready so it was not run automatically after `kubeadm init`.
* Delete the 

# Packages

|Package Name|Description|
|---|---|
|aws-ubuntu-kube-control.pkr.hcl  |kuberenetes control plane|
|aws-ubuntu-kube-worker.pkr.hcl   |kuberenetes workers|



