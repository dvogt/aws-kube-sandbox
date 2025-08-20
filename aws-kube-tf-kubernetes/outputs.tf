
# ============================================================
# General output
# ============================================================

output "general__output" {
  value = "============ General output =================="
}

output "general_ami_vpc" {
  value = module.network.aws_vpc_id
}

output "general_ingress_ip_v6" {
  #value = var.ingress_ip_v6
  value = local.ingress_ip_v6
}

# output "general_ingress_ip_v4" {
#   value = local.ingress_ip_v4
# }
# output "aws_internet_gateway" {
#   value = module.network.aws_internet_gateway
# }

# ============================================================
# Bastion output
# ============================================================

output "bastion__output" {
  value = "============ Bastion output =================="
}

output "sn_bastion" {
  value = module.network.sn_bastion
}

# output "bastion_public_ipv4" {
#   value = module.cp-bastion.bastion_public_ip
# }

output "bastion_private_ip" {
  value = module.bastion.bastion_private_ip
}

output "bastion_ipv6" {
  value = "ssh ubuntu@${module.bastion.bastion_ipv6[0]}"
}


# ============================================================
# Kub Worker output
# ============================================================

output "kub__output" {
  value = "============ Kub workers output =================="
}

output "kub_worker_private_ip" {
  value = module.kub-workers.kub_worker_private_ip
}

output "kub_controller_private_ip" {
  value = module.kub-workers.kub_controller_private_ip
}

