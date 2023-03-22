
# ============================================================
# General output
# ============================================================

output "general__output" {
  value = "============ General output =================="
}

output "vpc_id" {
  value = module.network.aws_vpc_id
}

output "subnet_id" {
  value = module.network.sn_packer_id
}

output "general_ingress_ip_v6" {
  value = local.ingress_ip_v6
}

output "general_ingress_ip_v4" {
  value = local.ingress_ip_v4
}




