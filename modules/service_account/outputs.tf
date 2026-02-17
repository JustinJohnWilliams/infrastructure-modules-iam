output "user_arn" {
  value = aws_iam_user.user.arn
}

output "user_name" {
  value = aws_iam_user.user.name
}

output "credentials" {
  value = {
    "ACCESS_KEY_ID"     = aws_iam_access_key.access_key.id
    "SECRET_ACCESS_KEY" = aws_iam_access_key.access_key.secret
    "SMTP_PASSWORD"     = "go run this python script: https://docs.aws.amazon.com/ses/latest/dg/smtp-credentials.html"
  }
  sensitive = true
}
