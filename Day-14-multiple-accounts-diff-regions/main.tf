resource "aws_s3_bucket" "name" {
    bucket = "ycvbhjnklm"
    provider = aws.dev-account
  
}

resource "aws_s3_bucket" "name" {
    bucket = "ycvbhjdddnklm"
    provider = aws.test-account
  
}