terraform {
  backend "s3" {
    bucket         = "multi-tenant-users"
    key            = "tenant-state/${terraform.workspace}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    use_lockfile   = true
  }
}
