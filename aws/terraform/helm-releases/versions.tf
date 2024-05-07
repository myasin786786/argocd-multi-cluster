terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.47"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~>2.13.1"
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.shared.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.shared.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args = [
        "eks", "get-token",
        "--cluster-name", var.argocd_eks_cluster_name,
        "--role-arn", local.argocd_provider_assume_role_arn,
      ]
    }
  }
}

provider "aws" {
  alias               = "argocd"
  region              = var.region
  allowed_account_ids = [var.argocd_account_id]

  assume_role {
    role_arn     = local.argocd_provider_assume_role_arn
    session_name = "argocd-multi-eks-cluster"
  }

  default_tags {
    tags = local.default_tags
  }
}
