

# About aws-kube development sandbox

This is a [development sandbox](https://en.wikipedia.org/wiki/Sandbox_(software_development)) for deployment and testing of a simplified native Kubernetes cluster using EC2 images in AWS. This is used for development purposes and exposes you to some technologies that you might expect in prodcution like environments. To keep costs down it only uses services that are  essential for setting up and managing a Kubernetes Cluster. 

This was originally developed to get experience with deploying and managing a Kubernetes cluster that is highly repeatable. It was desgined so that it could be spun up and destroyed quickly to save expenses running the resources in AWS. 

This was created as a two phase project:
* This first phase was to create a native Kubernetes infrastucture in AWS using popular platform engineering tools. 
* The second part (*work in progress*) is to setup a CI/CD pipeline for building an deploying images on the Kuberetes cluster.

# How to use this project

There are four directories used for different files and code.
Each of the diretories has it's own **README** file that gives specific instructions.
These are designed to be followed in order.

|Step|Directory|Description|
|---|---|--|
|**1**|aws-kube-ansible-builds|Test the Ansible code locally using Vagrant|
|**2**|aws-kube-shared        |Update your public ssh key and aws credentials to be used by Terraform|
|**3**|aws-kube-tf-packer    |Create the AWS VPC to build AMI Images using Terraform |
|**4**|aws-kube-ansible-builds|Use Packer to build your AMI images|
|**5**|aws-kube-tf-packer    |Destroy the AWS VPC to build AMI Images|
|**6**|aws-kube-tf-kubernetes |Use Terraform to build an AWS VPC to spin up a Kubernetes cluster using the AMI Images.|

**Next Steps**
* Log in to the Bastion Host
* Log in to the Kube Controller
* Play in the sandbox. Be courages and break things. It is the best way to learn. Besides that you can always destroy the environment and start over.

# Framework parameters that were in scope for this project

* At least 1 Kube Controller.
* At least 2 Kube Workers.
* Test builds locally.
* Build AWS AMI images for reuse and quick deployment.
   * Note: The AWS AMI images are stored on AWS even after the VPCs are destroyed.
* All AWS instances are reachable from a single bastion host.


# Out of Scope parameters
* Redundancy of the environment. 
* More to come.
 

# Features

* **Kuberentes Cluster:**
  * Play around with Kubernetes. 
* **AWS:**
  * Experience building evnironments in AWS using popular platform enigineering tools.
* **Terraform:** to create two independent VPCs:
  * One VPC to create AMI images.
  * One VPC to create the Kubernetes cluster.
* **Vagrant:**
  * To test images before building in AWS.
* **Packer:**
  * To build AMI images. 
* **Ansible:** 
  * To deploy software packages and add configuration files to the images. 
* **IPv6:**
  * Get expereince with IPV6
  * A NAT Gateway for IPv4 is included but has been commented out. This can be found in:
       * aws-kube-tf-kuberentes/modules/network/nat.tf
  * To avoid building and paying for a NAT Gateyway
  * Added security to make sure that only my host can connect directly to the bastion host.
  

# Prerequsites and versions

There is nothing worse than downloading code and running it, only to find out that something breaks and the old resources are no longer avaiable. This is one of the reasons for building your own AMI images. This is also a good reason for maintaining your own artifacts. While building this environment, the calico network file moved. For this reason, I have downloaded the calico file to be able to repeat the build reliabley. 

For that reason, I am listing the known versions to work with this enviroment. 

|Software|Version|
|---|---|
|Vagrant|2.3.4|
|Ansible|2.14.3|
|Packer|1.86|
|Packer Amazon Plugin|0.0.2|
|Terrform|1.4.2|
|Vagrant Ubuntu Image|TBD|
|AWS Ubuntu Image|ubuntu-jammy-22.04-amd64-server-*|
|Kubernetes packages|kubeadm=1.26.3-00<br/>kubelet=1.26.3-00<br/>kubectl=1.26.3-00|
|Docker packges||



# About IPv6 in this environment

I should probably write a blog about my full experience with this. 
If you are lucky enough to have an Internet Service Provider that automatically provides you with routable IPv6, then you should be good to go. 

It might be tempting to search Google for `What is my IP` to see if you are using IPv6. In some cases, Google will not provide your IPv6 address even though you may have an IPv6 address. [whatismyipaddress.com](https://whatismyipaddress.com) will not provide your IPv6 address either. 

The best way of seeing if you have an IPv6 address is to run: `curl -S ipv6.icanhazip.com` or going to http://ipv6.icanhazip.com. ipv6.icanhazip.com does not have an IPv4 DNS entry so don't expect it work if you are only using IPv4. Use http://ipv4.icanhazip.com if you want to see your IPv4 address.

The provided Terraform code runs `curl -S ipv6.icanhazip.com` to get your IPv6 address and uses it when setting up the `aws_security_group`. 


## What if I don't have an IPv6 address? 

There are some VPN services that offer IPv6. Most of the popular VPNs don't offer IPv6. 
Here are a few VPNs tha offer IPv6 in no paticular order:
* [Hideme](hide.me)
* [Perfect Privacy](www.perfect-privacy.com)
* [airvpn.org](airvpn)

**Disclaimer:** I am not paid for listing these VPN providers nor do I endorse any particular provider. There are a few other VPN Services that offer IPv6 addresses. It should be noted that the field of VPN services offering IPv6 was rather limited when I was testing this in early 2023.

For reference I do use perfect-privacy. I am not sure that either of those statements (perfect or privacy) are correct. I am able to get IPv6 which suited my needs. Also while experimenting with the Perfect Privacy VPN app, I found that IPv6 wasn't working. I used the native VPN (IKEv2) on the Mac to connect to the Perfect Privacy servers and I was able to get an IPv6 address. I spent a lot of time trying to figure this all out. 

## Backstory on using IpV6

I was initially setting up this environment for myself. I also wanted to get exposure to IPv6. At the time I was using Xfinity for my internet. Xfinity was using a NAT'd IPv6 on my router. I moved away from Xfinity and the new provider does not "support" IPv6. I wanted a quick way to keep working with IPv6 without having to fix all the Terraform code at the time. 

# Reference Diagram for AWS Kube Cluster

AWS-Kubernets-Design-Arch.png



