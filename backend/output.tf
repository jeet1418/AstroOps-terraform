output "arn" {
  description = "The ARN of the S3 bucket"
  value = aws_s3_bucket.terraform_state.arn
}
output "lock_table_name" {
  description = "The name of the DynamoDB table used for state locking"
  value = aws_dynamodb_table.terraform_state_lock.name
}