resource "aws_s3_bucket" "test" {
  bucket_prefix = "test-bucket"
}

resource "aws_s3_bucket_public_access_block" "test" {
  bucket                  = aws_s3_bucket.test.id
  block_public_acls       = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_dynamodb_table" "test" {
  name           = "dynamodb"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "test"

  attribute {
    name = "test"
    type = "S"
  }
}
