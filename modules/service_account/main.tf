locals {
  policy_name = "${var.name}-service-policy"
}

resource "aws_iam_policy" "service_role_policy" {
  name   = local.policy_name
  path   = "/service-role/"
  policy = data.aws_iam_policy_document.service_role_policy.json
  tags   = var.tags
}

data "aws_iam_policy_document" "service_role_policy" {
  dynamic "statement" {
    for_each = var.iam_policies

    content {
      actions   = statement.value.Actions
      resources = statement.value.Resources
      effect    = statement.value.Effect
      sid       = statement.key
    }
  }
}

resource "aws_iam_user" "user" {
  name = var.name
  tags = var.tags
}

resource "aws_iam_user_policy_attachment" "policy_attachment" {
  user       = aws_iam_user.user.name
  policy_arn = aws_iam_policy.service_role_policy.arn
}

resource "aws_iam_access_key" "access_key" {
  user       = var.name
  depends_on = [aws_iam_user.user]
}
