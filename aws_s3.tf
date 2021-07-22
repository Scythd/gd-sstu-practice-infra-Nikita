resource "aws_s3_bucket" "terraform-state-bucket" {
  bucket = "scythd-terraform-state-bucket"
  versioning {
    enabled = true
  }
}