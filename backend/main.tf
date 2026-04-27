provider "aws" {
  region = "us-east-1"
}

#s3 bucket for terraform state 
resource "aws_s3_bucket" "tf_state" {
  bucket = "terraform-state-ramesh-069"

  tags = {
    Name = "terrafrom-state"
  }
}

#enable versioning

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

#enable encryption

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.tf_state.id

  rule {

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

#Dynamo DB table for state locking

resource "aws_dynamodb_table" "tf_locks" {
  name         = "tf_locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}