###########################################################
#         Controller cloud init                           #
###########################################################
locals {
  crtl_kube_adm_sh_body = templatefile("${path.module}/templates/ctrl_kubeadm.sh", {
    retries       = 0
    max_retries   = 60
    sleep         = 5
    aws_region    = var.aws_region
    k8s_ssm_join  = var.k8s_ssm_join
  })
}

locals {
  crtl_add_config_to_secrets_body = templatefile("${path.module}/templates/ctrl_add_config_to_secrets.sh", {
    retries             = 0
    max_retries         = 60
    sleep               = 5
    aws_region          = var.aws_region
    k8s_secrets_config  = var.k8s_secrets_config
  })
}

locals {
  ctrl_cloud_init = templatefile("${path.module}/templates/ctrl_cloud_init.yaml", {
    kube_adm_sh_body            = local.crtl_kube_adm_sh_body
    add_config_to_secrets_body  = local.crtl_add_config_to_secrets_body
    k8s_internal_cluster_ip     = "10.96.0.1"
    podSubnet                   = "192.168.0.0/16"
    serviceSubnet               = "10.96.0.0/12,fd00:10:96::/112"
    dns                         = var.controller_r53_record
    bucket_name                 = local.bucket_name
    aws_region                  = var.aws_region
  })
}

###########################################################
#                Worker cloud init                        #
###########################################################

locals {
  wrkr_join_cluster_body = templatefile("${path.module}/templates/wrkr_join_cluster.sh", {
    retries       = 0
    max_retries   = 60
    sleep         = 5
    aws_region    = var.aws_region
    k8s_ssm_join  = var.k8s_ssm_join
  })
}
 
locals {
  wrkr_cloud_init = templatefile("${path.module}/templates/wrkr_cloud_init.yaml", {
    wrkr_join_cluster_body = local.wrkr_join_cluster_body
  })
}

