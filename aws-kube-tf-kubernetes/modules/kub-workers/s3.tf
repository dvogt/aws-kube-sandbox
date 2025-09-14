# This is because the calico file is to large to be uploaded as user data

resource "random_id" "bucket_suffix" {
  byte_length = 4 # 8 hex chars; plenty of uniqueness
}

locals {
  bucket_name = "k8s-sandobx-${random_id.bucket_suffix.hex}"
}

resource "aws_s3_bucket" "k8s_sandbox" {
  bucket = local.bucket_name
  force_destroy = true
}

# TODO: calico should be a variable
resource "aws_s3_object" "calico" {
  bucket = local.bucket_name
  key    = "configs/k8s_sandbox/ctrl_calico.yaml"                   # path in S3
  source = "${path.module}/files/ctrl_calico.yaml"            # local file on your repo
  etag   = filemd5("${path.module}/files/ctrl_calico.yaml")   # re-upload on content change

  content_type = "text/yaml"
  server_side_encryption = "AES256"                      # optional but recommended
}

data "aws_iam_policy_document" "s3_config" {
  statement {
    sid     = "S3bucket"
    effect  = "Allow"
    actions = [
                "s3:GetBucketLocation",
                "s3:GetObject",
                "s3:PutObject",
                "s3:ListBucket"
                ]
    resources = ["arn:aws:s3:::${local.bucket_name}",
                 "arn:aws:s3:::${local.bucket_name}/*"
               ]        
  }
}

resource "aws_iam_policy" "s3_config" {
  name   = "s3_config"
  policy = data.aws_iam_policy_document.s3_config.json
}

resource "aws_iam_role_policy_attachment" "attach_s3_config" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_config.arn
}
