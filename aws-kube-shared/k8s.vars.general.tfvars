

# ======================================================
# General Project Vars
# ======================================================
aws_ami_owners              = ["099720109477"]
aws_ami_images              = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
aws_ami_kube_control_images = ["kube-control-*"]
aws_ami_kube_worker_images  = ["kube-worker-*"]
k8s_ssm_join                = "k8s-join" 
k8s_secrets_config          = "k8s-config" 
aws_region                  = "us-east-1"
aws_az_1                    = "us-east-1b"


# ======================================================
# General Networking
# ======================================================
vpc_ipv6_netmask_length  = "56"
vpc_cidr                 = "10.0.0.0/16"

# ===============================================
# Bastion Vars
# =============================================
cidr_bastion                   = "10.0.3.0/28"
bastion_instance_type           = "t2.micro"
bastion_disable_api_termination = false


# ======================================================
# Kube Workers
# ======================================================

cidr_kube_workers         = "10.0.5.0/24"
kube_controller_ip        = "10.0.5.10"
kub_worker_instance_type  = "t2.medium"
controller_r53_ttl        = "300"
kube_workers_ips  = {
    "0" = "10.0.5.102"
    "1" = "10.0.5.103"
  }
  # "2" = "10.0.5.104"
  
