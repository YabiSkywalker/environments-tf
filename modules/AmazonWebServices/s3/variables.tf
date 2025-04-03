variable "bucket" {
    description = "Bucket name"
    type        = string
}
variable "force_destroy" {
    description = "Force destroy option"
    type        = bool
}

variable "block_public_acl" {
    description = "Block public acl definition"
    type        = bool
}

variable "block_public_policy" {
    description = "Block public iam policies"
    type        = bool
}

variable "ignore_public_acl" {
    description = "Ignore public access control list"
    type        = bool
}

variable "enable_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}

variable "tags" {
    description = "Bucket tag"
    type        = map(string)
}



