output "policy" {
  value = var.create_policy ? aws_iam_policy.this[0] : null
}

output "policy_doc_json" {
  value = data.aws_iam_policy_document.policy_doc.json
}
