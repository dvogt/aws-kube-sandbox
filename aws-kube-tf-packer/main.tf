terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

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

# -----------------------------

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

  # Module Specific Vars
  cidr_packer   = var.cidr_packer
  ingress_ip_v6 = local.ingress_ip_v6
  ingress_ip_v4 = local.ingress_ip_v4
}
