resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.frontend_vpc.id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [aws_route_table.frontend_private_rtb01.id, aws_route_table.frontend_private_rtb02.id, aws_route_table.frontend_private_rtb03.id]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "ReadOnlyThisServiceArtifact"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::${var.artifacts_bucket}/*"
      }
    ]
  })

  tags = {
    Name = "${var.frontend_prefix}-ssm-artifacts-file-s3-endpoint"
  }
}