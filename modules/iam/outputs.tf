output "iam_policy_arn" {
  description = "The arn of the aws iam policy"
  value = aws_iam_policy.this.arn
}

output "iam_policy_name" {
  description = "The name of the aws iam policy"
  value = aws_iam_policy.this.name
}

output "iam_instance_profile_name" {
  description = "Name of the instance profile resource"
  value = aws_iam_instance_profile.this.name
}