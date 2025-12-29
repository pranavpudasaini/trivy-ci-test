resource "aws_s3_bucket" "test" {
  bucket_prefix = "test-bucket"
}

resource "aws_kms_key" "s3" {
  description             = "Custom multi-region KMS key to encrypt S3 bucket"
  multi_region            = true
  deletion_window_in_days = 1
}

resource "aws_s3_bucket_server_side_encryption_configuration" "test" {
  bucket = aws_s3_bucket.test.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.s3.arn
    }
  }
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
