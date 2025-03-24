variable "iam_role_name" {
    description = "Name for IAM role"
    type        = string
}

variable "iam_role_policy" {
    description = "IAM role policy"
    type        = string
    default     = ""
}

variable "iam_policy_name" {
    description = "Name for IAM policy specific to bucket"
    type        = string
}

variable "iam_policy_document" {
    description = "JSON policy"
    type        = string
    default     = ""
}

variable "iam_instance_profile_name" {
    description = "IAM instance profile name"
    type        = string
}