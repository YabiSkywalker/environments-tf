output "bucket_id" {
  description     = "The id of the buckets"
  value           = aws_s3_bucket.this.id
}

output "bucket" {
  value = aws_s3_bucket.this.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}

output "bucket_versioning" {
  description     = "The versioming of the buckets"
  value           = aws_s3_bucket.this.versioning
}


