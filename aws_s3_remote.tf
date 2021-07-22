terraform {
  backend "s3" {
    bucket         = "scythd-terraform-state-bucket"
    key            = "network/terraform.tfstate"
    region         = "us-east-1"
    access_key     = "AKIASSD7SMFX5TVBZFJD"
    secret_key     = "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"
    dynamodb_table = "scythd-terraform-state-table"
    encrypt        = true
  }

}