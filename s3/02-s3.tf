resource "aws_s3_bucket" "static_site" {
  bucket = "site-do-helder"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = {
    Name        = "Site do Helder"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.static_site.bucket
  key    = "index.html"
  source = "index.html"
  acl    = "public-read"

  metadata = {
    CacheControl = "no-cache"
  }
}
