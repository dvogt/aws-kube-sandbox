resource "aws_ssm_parameter" "k8s_ssm_join" {
  name        = var.k8s_ssm_join
  description = "k8s command to join the cluster"
  type        = "String"
  value       = "blank"
  overwrite   = true

  tags = {
    Name = "${var.project_name} ${var.module_name}"
  }
}