# providers.tf
provider "aws" {
  region = "us-east-1"  # Explicit region declaration
}

data "aws_eks_cluster" "existing" {
  name = "terraform-eks-test"
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.aws_eks_cluster.existing.name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.existing.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.existing.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
