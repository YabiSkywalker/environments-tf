resource "aws_s3_bucket" "this" {
  bucket          = var.bucket
  force_destroy   = var.force_destroy
  tags = var.tags
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

#bucket access control list
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id


  block_public_acls   = var.block_public_acl
  block_public_policy = var.block_public_policy
  ignore_public_acls  = var.ignore_public_acl
}

resource "aws_iam_policy" "bucket_policy" {

  name        = var.bucket_iam_policy_name
  path        = "/"
  description = "Allow "
  policy      = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject"
        ],
        "Resource" : [
          "arn:aws:s3:::*/*",
          "arn:aws:s3:::umeet-dev-bucket"
        ]
      }
    ]
  })
}
