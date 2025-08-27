
# # --- Controller role (can write the join command) ---

# # resource "aws_iam_policy" "ctl_ssm_write" {
# #   name   = "k8s-ctl-ssm-write"
# #   policy = jsonencode({
# #     Version = "2012-10-17",
# #     Statement = [{
# #       Effect   = "Allow",
# #       Action   = ["ssm:PutParameter"],
# #       Resource = "arn:aws:ssm:us-east-1:${data.aws_caller_identity.current.account_id}:parameter/${var.param_k8s_join}"
        
# #       #Resource = "*", # keep simple; restrict to the exact ARN in prod
# #       # Condition = { 
# #       #   Bool = {
# #       #     "ssm:Overwrite" = "true"
# #       #   }
# #       #   "StringEquals": { "ssm:ResourceTag/Project": var.param_k8s_join } 
# #       # }
# #     }]
# #   })
# # }

# data "aws_caller_identity" "current" {}

# resource "aws_iam_role_policy_attachment" "ctl_ssm_write_attach" {
#   role       = aws_iam_role.ctl_role.name
#   policy_arn = aws_iam_policy.ctl_ssm_write.arn
# }

# # # --- Worker role (can read the join command) ---
# resource "aws_iam_role" "wrk_role" {
#   name               = "k8s-wrk-role"
#   assume_role_policy = data.aws_iam_policy_document.ec2_trust.json
# }

# resource "aws_iam_instance_profile" "wrk_profile" { 
#     role = aws_iam_role.wrk_role.name 
# }

# resource "aws_iam_policy" "wrk_ssm_read" {
#   name   = "k8s-wrk-ssm-read"
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Effect   = "Allow",
#       Action   = ["ssm:GetParameter"],
#       Resource = "*"
#     }]
#   })
# }
# resource "aws_iam_role_policy_attachment" "wrk_ssm_read_attach" {
#   role       = aws_iam_role.wrk_role.name
#   policy_arn = aws_iam_policy.wrk_ssm_read.arn
# }

# data "aws_iam_policy_document" "ec2_trust" {
#   statement {
#     effect = "Allow"

#     principals {  
#       identifiers = ["ec2.amazonaws.com"]
#        type = "Service"
#     }

#     actions = ["sts:AssumeRole"]
    
#   }
# }

# resource "aws_iam_role" "ctl_role" {
#   name               = "k8s-ctl-role"
#   assume_role_policy = data.aws_iam_policy_document.ec2_trust.json
# }

# resource "aws_iam_instance_profile" "ctl_profile" { 
#   role = aws_iam_role.ctl_role.name 
# }


############################
# Data helpers
############################
data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

############################
# Variables (tune as needed)
############################
# variable "param_path_prefix" {
#   description = "Prefix under which the instance can manage SSM parameters"
#   type        = string
#   default     = "/myapp/*"
# }

############################
# Trust policy (EC2 assumes role)
############################
data "aws_iam_policy_document" "ec2_trust" {
  statement {
    sid     = "EC2AssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = "ec2-ssm-parameter-writer"
  assume_role_policy = data.aws_iam_policy_document.ec2_trust.json
}

############################
# IAM permissions (allow overwrite of SSM params under prefix)
############################
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
      "arn:${data.aws_partition.current.partition}:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${var.param_k8s_join}"
    ]

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
      "arn:${data.aws_partition.current.partition}:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/${var.param_k8s_join}"
    ]
  }
}

resource "aws_iam_policy" "ssm_put_policy" {
  name   = "ec2-ssm-overwrite-parameters"
  policy = data.aws_iam_policy_document.ssm_put_with_overwrite.json
}

resource "aws_iam_role_policy_attachment" "attach_put_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ssm_put_policy.arn
}

############################
# Instance profile for EC2
############################
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-ssm-parameter-writer-profile"
  role = aws_iam_role.ec2_role.name
}

############################
# Example EC2 usage (attach the profile)
############################
# resource "aws_instance" "example" {
#   ami                    = "ami-xxxxxxxx"
#   instance_type          = "t3.micro"
#   iam_instance_profile   = aws_iam_instance_pr_


