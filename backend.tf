terraform {
  backend "s3" {
    bucket = "bucketcloud1608"
    region = "us-east-2"
    key    = "terraform-backend/terraform.tfstate"
  }
}