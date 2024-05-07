locals {
  default_tags = {
    managed_by      = "terraform"
    gitops_operator = "argocd"
    environment     = "dev"
    github_repo     = "ishuar/argocd-multi-cluster"
  }

  argocd_provider_assume_role_arn = "arn:aws:iam::${var.argocd_account_id}:role/${var.provider_assume_role_name}"
}
