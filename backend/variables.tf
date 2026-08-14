variable "bucket_name" {
  description = "The name of the S3 bucket to store Terraform state"
  type        = string
  default     = "astro-state-bucket"
}

variable "lock_table_name" {
  description = "The name of the DynamoDB table to use for state locking"
  type        = string
  default     = "astro-state-lock"
}

variable "aws_region" {
  description = "The AWS region where the S3 bucket and DynamoDB table are located"
  type        = string
  default     = "us-east-1"
}