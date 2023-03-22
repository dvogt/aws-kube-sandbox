
# data "aws_iam_policy_document" "assume_s3_role" {
#   statement {
#     effect  = "Allow"
#     actions = ["sts:AssumeRole"]
#     principals {
#       type        = "Service"
#       identifiers = ["s3.amazonaws.com"]
#     }
#   }
# }

# resource "aws_iam_policy" "gl_s3_policy" {
#   name        = "gl-s3-policy"
#   description = "gl-s3 Policy"

#   # Terraform's "jsonencode" function converts a
#   # Terraform expression result to valid JSON syntax.
#   policy = data.aws_iam_policy_document.gl_s3_policy.json
# }

# resource "aws_iam_role" "s3access_role" {
#   name               = "S3Access_Role"
#   assume_role_policy = data.aws_iam_policy_document.assume_s3_role.json
# }

# resource "aws_iam_policy_attachment" "s3access_attach" {
#   name       = "s3access-to-s3-policy"
#   roles      = [aws_iam_role.s3access_role.name]
#   policy_arn = aws_iam_policy.gl_s3_policy.arn
# }



