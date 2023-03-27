
# How to build images

## Build images locally with Vagrant first for testing
   * cd to the build directory you want to test with Vagrant
      * For example: `cd builds/kube-worker`
   * *Run:* `vagrant up`
   * Make sure there are no errors
   * If necessary ssh and debug Vagrant image: `vagrant ssh`
   * Make changes to the `roles/<build directory>`
   * If necessary rerun provision: `vagrant provision`
   * Once there are no errors go to **Build with packer**


### Extra steps after building the Contorller node with Vagrant
1. `ssh vagrant`
2. As the ubuntu user run: `./kubeadm.sh`
   * Make sure it runs without errors
     * You should something like: `kubeadm join 10.0.2.15:6443 ...`
3. As the ubuntu user run: ./calico.sh
   * Make sure it runs without errors
     * You should something like: `kubeadm join 10.0.2.15:6443 ...`

### Destroy the Vagrant box

Destroy the Vagrant box. The pupose was to make sure that Ansible would build correctly.
* `exit` from you vagrant box if you haven't already done so
* *Run:* `vagrant destroy`

## Build with Packer and store on AWS
   * Create the Packer AWS VPC. See https://github.com/dvogt/aws-cube/aws-kube-tf-packer/README.md
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

## Next Step

1. Follow the instructions at https://github.com/dvogt/aws-cube/aws-kube-tf-kubernetes/README.md


# Notes

* `kubeadm init` is run manually on the AWS instance after it has been deployed into your environment. This is is because the credentials are tied to the IP of the instances.
* `calico.sh` is run manully because it needs `kubeadmn init` to be run first. At the time of this writing it was difficult to know when kubeadmin was ready so it was not run automatically after `kubeadm init`.
* Delete the 

# Packages

|Package Name|Description|
|---|---|
|aws-ubuntu-kube-control.pkr.hcl  |kuberenetes control plane|
|aws-ubuntu-kube-worker.pkr.hcl   |kuberenetes workers|



