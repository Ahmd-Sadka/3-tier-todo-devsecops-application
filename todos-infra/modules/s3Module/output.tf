output "bucket_arn" {
  value = aws_s3_bucket.main.arn
}

output "bucket_name" {
  value = aws_s3_bucket.main.id
}

output "dynamodb_table_name" {
  value = try(aws_dynamodb_table.terraform_lock[0].name, null)
}