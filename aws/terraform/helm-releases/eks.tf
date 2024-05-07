data "aws_eks_cluster" "shared" {
  provider = aws.argocd
  name     = var.argocd_eks_cluster_name
}
