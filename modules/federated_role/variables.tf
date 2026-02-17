# ============================================================================
# Generic OIDC Federated Role Module
# ============================================================================

# variables.tf
variable "oidc_role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the OIDC provider"
  type        = string
}

variable "oidc_provider_url" {
  description = "URL of the OIDC provider (e.g., oidc.eks.us-west-2.amazonaws.com/id/XXXXX)"
  type        = string
}

variable "kubernetes_namespace" {
  description = "Kubernetes namespace for the service account"
  type        = string
  default     = "default"
}

variable "kubernetes_service_account" {
  description = "Name of the Kubernetes service account"
  type        = string
}

variable "role_policy_attachments" {
  description = "List of IAM policy ARNs to attach to the role"
  type        = list(string)
  default     = []
}

variable "additional_audiences" {
  description = "Additional audiences to allow (beyond sts.amazonaws.com)"
  type        = list(string)
  default     = []
}

variable "tags" {
  type = map(any)
}