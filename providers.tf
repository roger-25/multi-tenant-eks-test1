# providers.tf
provider "aws" {
  region = "us-east-1"  # Explicit region declaration
  # Add these if using specific credentials
  # access_key = var.aws_access_key
  # secret_key = var.aws_secret_key
}

data "aws_eks_cluster" "existing" {
  name = "eksdemo1"
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.aws_eks_cluster.existing.name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.existing.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.existing.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
