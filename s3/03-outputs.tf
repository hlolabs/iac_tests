output "s3_bucket_website_endpoint" {
  value = aws_s3_bucket.static_site.website_endpoint
}
