terraform {
  backend "s3" {
    bucket         = "multi-tenant-users"
    region         = "us-east-1"
    key            = "tenant-state/placeholder/terraform.tfstate" # <-- static dummy
    dynamodb_table = "multi-tenant-db"
  }
}