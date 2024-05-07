resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "6.7.18"
  create_namespace = true
  namespace        = "argocd"

  values = [
    templatefile("${path.module}/values/argocd.yaml",
      {
        PREFIX = var.prefix
      }
    )
  ]
}

resource "helm_release" "argocd_bootstrap_app" {
  name             = "argocd-apps"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd-apps"
  version          = "2.0.0"
  create_namespace = false
  namespace        = "argocd"
  atomic           = false


  ## Why using file() with values -> https://github.com/hashicorp/terraform-provider-helm/issues/838
  values = [
    templatefile("${path.module}/values/argocd-apps.yaml",
      {
        PREFIX = var.prefix
      }
    )
  ]

  depends_on = [
    helm_release.argocd
  ]
}
