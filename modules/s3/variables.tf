variable "bucket" {
    description = "Bucket name"
    type        = string
}

variable "enable_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}

variable "bucket_policy" {
  description = "S3 bucket policy JSON"
  type        = string
  default     = "{}"
}

variable "tags" {
    description = "Bucket tag"
    type        = map(string)
}