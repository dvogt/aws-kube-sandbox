# About aws-kube development sandbox

This is a [development sandbox](https://en.wikipedia.org/wiki/Sandbox_(software_development)) for deployment and testing of a simplified native Kubernetes cluster using EC2 images in AWS. This is used for development purposes. For simplicity and to keep costs down it only uses services that are essential for setting up and managing a Kubernetes cluster. There is an emphasis on building the infrastructure platform to build the Kubernetes cluster.

There are three distinct technologies that are used:
* **Vagrant**: to test images that will be deployed to AWS.
* **Packer:** to build the images that will be deployed to AWS.
* **Terraform:** to deploy your Kubernetes environment in AWS.

This was originally developed to:
* Create a native Kubernetes infrastucture in AWS using popular platform engineering tools. 
* Get experience with deploying and managing a Kubernetes cluster with a highly repeatable process.
* Have an environemnt could be spun up and destroyed quickly.
* Minimize expenses running resources in AWS. 
* Eventually integrate a CI/CD pipelnie deploy to apps on the Kubernetes cluster.

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

# Overview

There are four directories used for different files and code.
Each of the diretories has it's own **README** file that gives specific instructions.
These are designed to be used in the order the appear in the table below.

|Step|Directory|Description|
|---|---|--|
|**1**|aws-kube-shared        |Location of shared variables for Packer and Ansible |
|**2**|aws-kube-ansible-builds|Test the Ansible code locally using Vagrant to build your images|
|**3**|aws-kube-tf-packer     |Create an AWS VPC to build AMI Images using Terraform |
|**4**|aws-kube-ansible-builds|Use Packer to build your AMI images|
|**5**|aws-kube-tf-packer     |Destroy the AWS VPC that is used to build AMI Images|
|**6**|aws-kube-tf-kubernetes |Use Terraform to build an AWS VPC to spin up a Kubernetes cluster using the AMI Images.|

**Next Steps**
* Log in to the Bastion Host
* Log in to the Kube Controller
* Play in the sandbox. Be courages and break things. It is the best way to learn. In addittion that you can always destroy the environment and start over.


# Instructions for setting up your environment

* Make sure you have a publically routable IPv6 on your workstation (see [About IPv6](#about-ipv6-in-this-environment) below). 
* Add your public SSH key in *~/.ssh/id_rsa.pub*. This public key is added to your AMIs to log in to. 

* Add your [shared AWS credential file](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#shared-configuration-and-credentials-files) at ~home/.aws/credentials. This allows Terraform to build your environment in AWS.  

  ```
    [default]
    aws_access_key_id=<your aws access key>
    aws_secret_access_key=<your aws secret key>
  ```

# Framework parameters that were in scope for this project

* At least 1 Kube Controller.
* At least 2 Kube Workers.
* Test builds locally.
* Build AWS AMI images for reuse and quick deployment.
   * Note: The AWS AMI images are stored on AWS even after the VPCs are destroyed.
* All AWS instances are reachable from a single bastion host.

# Out of Scope parameters
* Redundancy of the environment. 
* How to use Kubernetes.

# Prerequsites and versions

There is nothing worse than downloading code and running it, only to find out that something breaks and the old resources are no longer avaiable. This is a good reason to  build your own AMI images and artifacts (config files etc.). An example of this pattern emerged while I was building **aws-kube** environment. The Calico network file moved. For this reason, I downloaded the Calico file to be able to repeat the build reliably.

I am listing exact versions that were used to build this enviroment. 

|Software|Version|
|---|---|
|Vagrant|2.3.4|
|Ansible|2.14.3|
|Packer|1.86|
|Packer Amazon Plugin|0.0.2|
|Terrform|1.4.2|
|Vagrant Ubuntu Image|ubuntu/jammy64|
|AWS Ubuntu Image|ubuntu-jammy-22.04-amd64-server-*|
|Kubernetes packages|kubeadm=1.26.3-00<br/>kubelet=1.26.3-00<br/>kubectl=1.26.3-00|
|Docker packges||

# Costs and Timing

## Timing
Generally the most time consuming piece is setting up your workspace environment (Terraform, AWS, Ansible, Packer and Vagrant) in addition to setting up tasks such your credenitals to allow Terraform to work with AWS. 

Once your workspace environment is setup, you can generally be up and running in AWS in a couple of hours that includes:

|Process|Timing|
|---|---|
|Building the two test Vagrant builds|~03:30 min: Build<br/>~00:09 min: Destroy|
|Creating and destroying the Packer VPC|~02:30 min: Build<br/>~01:00 min: Destroy|
|Building the two Kuberentes AMIs in the Packer VPC|~08:00: min each|
|Creating and destroying the Kubernetes VPC and cluster|**~02:30 min: Build**<br/>~01:00 min: Destroy|

After the two AMIs are built and stored in AWS, you will only need to *Create and destroy the Kubernetes VPC and clsuter*.

## Costs

My AWS costs for the month I was building (~10 times) the VPCs and resources cost me approximately $5 USD. This does not include the cost of storing the AMIs or running the AWS resources for extended periods of time. Of course your costs may vary. From my perspective, investing in my career and devlopment is definitely worth the cost of a couple of lattes at my favorite café. Remember to destroy your VPCs when not in use. 


### Keep costs down

Things to remember to keep costs down:
* Delete the Snapshots for the AMI images after de-registering the AMIs. They do not get deleted automatically.
* Destroy the VPCs with Terraform when not in use. 


# About IPv6 in this environment

I should probably write a blog about my full experience with this. 
If you are lucky enough to have an Internet Service Provider that automatically provides you with routable IPv6, then you should be good to go. 

It might be tempting to search Google for `What is my IP` to see if you are using IPv6. In some cases, Google will not provide your IPv6 address even though you may have an IPv6 address. For what it is worth, [whatismyipaddress.com](https://whatismyipaddress.com) will not provide your IPv6 address either. 

The best way of seeing if you have an IPv6 address is to run: `curl -S ipv6.icanhazip.com` or going to http://ipv6.icanhazip.com. ipv6.icanhazip.com does not have an IPv4 DNS entry so don't expect it work if you are only using IPv4. Use http://ipv4.icanhazip.com if you want to see your IPv4 address.

The provided Terraform code runs `curl -S ipv6.icanhazip.com` to get your IPv6 address and `curl -S ipv4.icanhazip.com` to get your IPv4 address. These IP addresses are used to limit access to you bastion hosts to those two IP addresses.

## How to get an IPv6 address? 

There are some VPN services that offer IPv6. Most of the popular VPNs don't offer IPv6. 
Here are a few VPNs that offer IPv6 in no paticular order:
* [Hideme](hide.me)
* [Perfect Privacy](www.perfect-privacy.com)
* [airvpn.org](airvpn)

**Disclaimer:** I am not paid for listing these VPN providers nor do I endorse any particular provider. 

There are a few other VPN Services that offer IPv6 addresses that are not listed here. It should be noted that the field of VPN services offering IPv6 was rather limited when I was testing this in early 2023. For reference I **do** use perfect-privacy. I can't attest to whether perfect-privacy has perfect privacy on not. I was able to get IPv6 which suited my needs. 

**NOTE:** I was **NOT** able to get an IPv6 address using the VPN app provided by Perfect Privacy. I ended up using the native Mac VPN (IKEv2) to connect to the Perfect Privacy servers and I was able to get an IPv6 address. I spent a lot of time trying to figure this all out so I hope this information is helpful. 

## I really need to use IPv4. 

The scaffolding for IPv4 addresses exists in the Terraform code. 
Although untested, you should be able to any references to `ingress_ip_v6` in the Terraform code and comment them out. 


## Backstory on using IpV6

I was initially setting up this environment for myself. I also wanted to get exposure to IPv6. At the time I was using Xfinity for my internet. Xfinity was using a NAT'd IPv6 on my router. I moved away from Xfinity and the new provider did not "support" IPv6. I wanted a quick way to keep working with IPv6 without having to fix the Terraform code at the time. 

# Reference Diagram for AWS Kube Cluster

* [AWS-Kubernets-Design-Arch.png](AWS-Kubernets-Design-Arch.png)



