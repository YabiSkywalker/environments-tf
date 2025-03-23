output "bucket_id" {
  description     = "The id of the buckets"
  value           = aws_s3_bucket.this.id
}

output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}

output "bucket_versioning" {
  description     = "The versioming of the buckets"
  value           = aws_s3_bucket.this.versioning
}


output "bucket_iam_policy_name" {
  value = aws_iam_policy.bucket_policy.name
}