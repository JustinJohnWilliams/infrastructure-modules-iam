locals {
  oidc_provider_stripped   = replace(var.oidc_provider_url, "https://", "")
  service_account_subject  = "system:serviceaccount:${var.kubernetes_namespace}:${var.kubernetes_service_account}"

  # Default EKS/IRSA audience is sts.amazonaws.com; allow callers to append more.
  audiences = concat(["sts.amazonaws.com"], var.additional_audiences)

  tags = merge(var.tags, {
    Name                     = var.oidc_role_name
    KubernetesNamespace      = var.kubernetes_namespace
    KubernetesServiceAccount = var.kubernetes_service_account
  })
}

resource "aws_iam_role" "federated_role" {
  name = var.oidc_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = var.oidc_provider_arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${local.oidc_provider_stripped}:sub" = local.service_account_subject
          "${local.oidc_provider_stripped}:aud" = local.audiences
        }
      }
    }]
  })

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "custom" {
  for_each = toset(var.role_policy_attachments)

  role       = aws_iam_role.federated_role.name
  policy_arn = each.value
}