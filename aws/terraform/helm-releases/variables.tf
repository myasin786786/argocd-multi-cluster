variable "region" {
  type        = string
  description = "(optional) Region of your aws account."
  default     = "eu-west-1"
}

variable "provider_assume_role_name" {
  type        = string
  description = "(required) The role name that needs to be assumed to access argocd ac"
}

variable "argocd_account_id" {
  type        = string
  description = "(optional) Account ID in which argocd EKS cluster is created"
}

variable "argocd_eks_cluster_name" {
  type        = string
  description = "(optional) EKS cluster name on which argocd will be deployed"
}

variable "prefix" {
  type        = string
  description = "(optional) prefix for resources and naming"
  default     = "argocd"
}
