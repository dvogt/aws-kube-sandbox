terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


# Can be commented out if using the default ~/.aws/credentials
# Can be commented out if using the default ~/.aws/credentials
provider "aws" {
  # shared_credentials_files = var.aws_credentials_for_tf
  profile = "default"
  region  = var.aws_region
}

# ----------------------------
# Get my IPv4 address
data "external" "getmyipv4" {
  program = ["sh", "-c", "echo '{ \"myipv4\": \"'$(curl -S ipv4.icanhazip.com)'/32\" }'"]
}

# -----------------------------
# Get my IPv6 address
data "external" "getmyipv6" {
  program = ["sh", "-c", "echo '{ \"myipv6\": \"'$(curl -S ipv6.icanhazip.com)'/128\" }'"]
}

locals {
  ingress_ip_v6 = data.external.getmyipv6.result["myipv6"]
  ingress_ip_v4 = data.external.getmyipv4.result["myipv4"]
}
# -----------------------------

module "network" {
  source = "./modules/network"

  # Standard Vars
  vpc_cidr     = var.vpc_cidr
  project_name = var.project_name
  aws_az_1     = var.aws_az_1

  # Module Specific Vars
  cidr_bastion      = var.cidr_bastion
  cidr_kube_workers = var.cidr_kube_workers
  ingress_ip_v6     = local.ingress_ip_v6
  ingress_ip_v4     = local.ingress_ip_v4
}

module "bastion" {
  source = "./modules/bastion"

  # Standard Vars
  project_name      = var.project_name
  ssh_key           = aws_key_pair.terraform_pub_key.id
  latest_ubuntu_ami = data.aws_ami.latest_ubuntu.id
  aws_vpc_id        = module.network.aws_vpc_id

  # Module Specific Vars
  bastion_disable_api_termination = var.bastion_disable_api_termination
  aws_subnet_bastion              = module.network.sn_bastion
  bastion_instance_type           = var.bastion_instance_type
  ingress_ip_v6                   = local.ingress_ip_v6
  ingress_ip_v4                   = local.ingress_ip_v4
  cidr_kube_workers               = var.cidr_kube_workers
  sg_kub_workers_id               = module.kub-workers.sg_kub_workers_id
}


module "kub-workers" {
  source = "./modules/kub-workers"

  # Standard Vars
  project_name = var.project_name
  aws_vpc_id   = module.network.aws_vpc_id
  ssh_key      = aws_key_pair.terraform_pub_key.id

  # Module Specific Vars
  kube_worker_ami          = data.aws_ami.kube_worker_ami.id
  kube_controller_ami      = data.aws_ami.kube_controller_ami.id
  sg_bastion_id            = module.bastion.sg_bastion_id
  kub_worker_instance_type = var.kub_worker_instance_type
  kube_workers_ips         = var.kube_workers_ips
  kube_controller_ip       = var.kube_controller_ip
  sn_kub_workers           = module.network.sn_kub_workers
  # ansible_security_groups = module.cp-ansible.sg_ansible
}
