output "iam_role_id" {
  description = "ID of IAM role"
  value       = aws_iam_role.this.id
}

output "iam_role_arn" {
  description = "ARN of IAM role"
  value       = aws_iam_role.this.arn
}

output "iam_role_name" {
  description = "Name of IAM role"
  value       = aws_iam_role.this.name
}

output "iam_role_path" {
  description = "Path of IAM role"
  value       = aws_iam_role.this.path
}

output "role_requires_mfa" {
  description = "Whether IAM role requires MFA"
  value       = var.role_requires_mfa
}

output "role_policy_inline" {
  description = "The raw inline policy"
  value       = data.aws_iam_policy_document.inline.json
}

output "role_policy_assume" {
  description = "The raw assume policy"
  value       = data.aws_iam_policy_document.assume_role["assumable"].json
}

output "raw" {
  description = "Raw info"
  value       = aws_iam_role.this
}
