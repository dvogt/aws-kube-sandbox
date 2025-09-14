

# This is to store the kube confg file, since it's over 4K and won't store in SSM parameters
resource "aws_secretsmanager_secret" "kube_config" {
  name                    = var.k8s_secrets_config
  description             = "Kube config stored in Secrets Manager"
  # kms_key_id              = var.kms_key_id != "" ? var.kms_key_id : null
  recovery_window_in_days = 0 # set >0 in prod to allow recovery on delete
  
  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}


