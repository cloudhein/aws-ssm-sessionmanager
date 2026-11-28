# Allow HTTPS downloads through the frontend S3 gateway endpoint.
resource "aws_s3_bucket_policy" "frontend_artifacts" {
  bucket = var.artifacts_bucket

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowGetObjectThroughServiceEndpoint"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::${var.artifacts_bucket}/*"

        Condition = {
          StringEquals = {
            "aws:SourceVpce" = aws_vpc_endpoint.s3.id
          }
          Bool = {
            "aws:SecureTransport" = "true"
          }
        }
      }
    ]
  })
}
