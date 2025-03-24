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



