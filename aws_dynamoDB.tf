resource "aws_dynamodb_table" "terraform-state-table" {
  hash_key     = "LockID"
  name         = "scythd-terraform-state-table"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}