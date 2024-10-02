data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

locals {
  account_id            = data.aws_caller_identity.current.account_id
  partition             = data.aws_partition.current.partition
  is_assumable          = length(concat(var.assume_policy_trusted_role_arns, var.assume_policy_trusted_role_services)) != 0 ? true : false
  inline_policy_name    = var.inline_policy_name == "" ? "${var.name}-policy" : var.inline_policy_name
  include_inline_policy = var.include_inline_policy && (length(var.default_inline_policy_actions) > 0 || length(var.iam_policies) > 0)
}

data "aws_iam_policy_document" "assume_role" {
  for_each = local.is_assumable ? toset(["assumable"]) : []

  dynamic "statement" {
    # https://aws.amazon.com/blogs/security/announcing-an-update-to-iam-role-trust-policy-behavior/
    for_each = var.allow_self_assume_role ? [1] : []

    content {
      sid     = "ExplicitSelfRoleAssumption"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "ArnLike"
        variable = "aws:PrincipalArn"
        values   = ["arn:${local.partition}:iam::${local.account_id}:role${var.role_path}${var.name}"]
      }
    }
  }

  statement {
    effect  = "Allow"
    actions = compact(distinct(concat(["sts:AssumeRole"], var.assume_policy_actions)))

    principals {
      type        = "AWS"
      identifiers = var.assume_policy_trusted_role_arns
    }

    principals {
      type        = "Service"
      identifiers = var.assume_policy_trusted_role_services
    }

    dynamic "condition" {
      for_each = var.role_requires_mfa ? [1] : []
      content {
        test     = "Bool"
        variable = "aws:MultiFactorAuthPresent"
        values   = ["true"]
      }
    }

    dynamic "condition" {
      for_each = var.role_requires_mfa ? [1] : []
      content {
        test     = "NumericLessThan"
        variable = "aws:MultiFactorAuthAge"
        values   = [var.mfa_age]
      }
    }

    dynamic "condition" {
      for_each = length(var.role_sts_externalid) != 0 ? [1] : []
      content {
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = var.role_sts_externalid
      }
    }
  }
}

data "aws_iam_policy_document" "inline" {
  dynamic "statement" {
    for_each = length(var.default_inline_policy_actions) > 0 ? [1] : []
    content {
      effect    = "Allow"
      actions   = var.default_inline_policy_actions
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = var.iam_policies

    content {
      sid       = statement.key
      actions   = statement.value.Actions
      resources = statement.value.Resources
      effect    = statement.value.Effect
      dynamic "principals" {
        for_each = lookup(statement.value, "Principal", null) != null ? [statement.value.Principal] : []
        content {
          type        = principals.value.Type
          identifiers = principals.value.Identifiers
        }
      }
      dynamic "not_principals" {
        for_each = lookup(statement.value, "NotPrincipal", null) != null ? [statement.value.NotPrincipal] : []
        content {
          type        = not_principals.value.Type
          identifiers = not_principals.value.Identifiers
        }
      }
      dynamic "condition" {
        for_each = lookup(statement.value, "Condition", null) != null ? [statement.value.Condition] : []
        content {
          test     = condition.value.Test
          variable = condition.value.Variable
          values   = condition.value.Values
        }
      }
    }
  }
}

resource "aws_iam_role" "this" {
  name                 = var.name
  path                 = var.role_path
  max_session_duration = var.max_session_duration
  description          = var.role_description

  force_detach_policies = var.force_detach_policies
  permissions_boundary  = var.role_permissions_boundary_arn

  assume_role_policy = local.is_assumable ? data.aws_iam_policy_document.assume_role["assumable"].json : null

  dynamic "inline_policy" {
    for_each = local.include_inline_policy ? [1] : []
    content {
      name   = local.inline_policy_name
      policy = data.aws_iam_policy_document.inline.json
    }
  }

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "custom" {
  for_each = toset(var.role_policy_attachments)

  role       = aws_iam_role.this.name
  policy_arn = each.value
}

resource "aws_iam_role_policy_attachment" "admin" {
  count = var.attach_admin_policy ? 1 : 0

  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "poweruser" {
  count = var.attach_poweruser_policy ? 1 : 0

  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_iam_role_policy_attachment" "readonly" {
  count = var.attach_readonly_policy ? 1 : 0

  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
