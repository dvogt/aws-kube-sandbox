############################
# Data helpers
############################
data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}


#####################################
# EC2 role for workers and controller
#####################################
resource "aws_iam_role" "ec2_role" {
  name               = "ec2_role_workers_controller"
  assume_role_policy = data.aws_iam_policy_document.ec2_trust.json
}

############################
# Instance profile for EC2
############################
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_role_workers_controller-profile"
  role = aws_iam_role.ec2_role.name
}

####################################################
# Trust policy (EC2 workers/controller assumes role)
####################################################
data "aws_iam_policy_document" "ec2_trust" {
  statement {
    sid     = "EC2AssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole",]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

##############################################################
# IAM permissions (allow overwrite of SSM params under prefix)
##############################################################
# NOTE:
# - Overwrite behavior is controlled by the API call (PutParameter with Overwrite=true).
# - The condition below further restricts that only overwriting calls are allowed.
# - Adjust resources to your required parameter paths.
data "aws_iam_policy_document" "ssm_put_with_overwrite" {
  statement {
    sid    = "AllowPutParameterWithOverwrite"
    effect = "Allow"
    actions = [
      "ssm:PutParameter"
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${var.k8s_ssm_join}",
    ]
    #  "arn:${data.aws_partition.current.partition}:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${var.k8s_secrets_config}"
   

    # Optional safety: only allow if the request sets Overwrite=true
    condition {
      test     = "Bool"
      variable = "ssm:Overwrite"
      values   = ["true"]
    }
  }

  # (Optional) Reads/listing if your app needs them
  statement {
    sid    = "AllowReadParametersUnderPrefix"
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath",
      "ssm:DescribeParameters"
    ]
    resources = [
      "arn:${data.aws_partition.current.partition}:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${var.k8s_ssm_join}"
    ]
    # "arn:${data.aws_partition.current.partition}:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${var.k8s_secrets_config}"
  }
}

###################################
# Policy to overwrite SSM Paramters
###################################
resource "aws_iam_policy" "ssm_put_policy" {
  name   = "ec2-ssm-overwrite-parameters"
  policy = data.aws_iam_policy_document.ssm_put_with_overwrite.json
}

resource "aws_iam_role_policy_attachment" "attach_put_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ssm_put_policy.arn
}

#################################
# Policy for pulling docker image
#################################
# data "aws_iam_policy" "ecr_readonly" {
#   arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
# }

# resource "aws_iam_role_policy_attachment" "nodes_ecr_ro" {
#   role       = aws_iam_role.ec2_role.name
#   policy_arn = data.aws_iam_policy.ecr_readonly.arn
# }


####################################
# Policy to allow controller to update secrets manager
####################################

data "aws_iam_policy_document" "controller_secrets_perm" {
  statement {
    sid     = "UpdateAndReadSecret"
    effect  = "Allow"
    actions = [
      "secretsmanager:PutSecretValue",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    # Include the secret ARN and all version ARNs
    resources = [
      aws_secretsmanager_secret.kube_config.arn,
      "${aws_secretsmanager_secret.kube_config.arn}*"
    ]
  }
}

resource "aws_iam_policy" "controller_secrets_policy" {
  name   = "controller-update-big-config-secret"
  policy = data.aws_iam_policy_document.controller_secrets_perm.json
}

# Attach to your controller's IAM role (replace with your role)
resource "aws_iam_role_policy_attachment" "controller_attach_secrets" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.controller_secrets_policy.arn
}

# An error occurred (AccessDeniedException) when calling the PutSecretValue operation: User: arn:aws:sts::685960513651:assumed-role/ec2_role_workers_controller/i-05e333cc5cb159e0e is not authorized to perform: secretsmanager:PutSecretValue on resource: k8s-join because no identity-based policy allows the secretsmanager:PutSecretValue action
