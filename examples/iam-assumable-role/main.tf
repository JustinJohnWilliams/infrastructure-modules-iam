provider "aws" {
  region = "us-west-2"
}

locals {
  security_account_id = "789707292350"
  dev_account_id      = "700453963330"
}

##########################################################
# IAM assumable role for admin
##########################################################
module "iam_assumable_role_admin" {
  source = "../../modules/role"

  name = "test-assumable-admin-role"
  assume_policy_trusted_role_arns = [
    "arn:aws:iam::${local.dev_account_id}:root",
  ]

  attach_admin_policy = true

  tags = {
    "foo" = "bar"
  }
}

##########################################################
# IAM assumable role for a service with attachments
##########################################################
module "iam_assumable_role_service_with_attachments" {
  source = "../../modules/role"

  name = "test-assumable-role-service-with-attachments"
  assume_policy_trusted_role_services = [
    "backup.amazonaws.com"
  ]

  role_policy_attachments = [
    "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup",
    "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
  ]


  tags = {
    "foo" = "bar"
  }
}

##########################################################
# IAM assumable role for a service, attachments, and no inline policy
##########################################################
module "iam_assumable_role_service_with_attachments_no_inline" {
  source = "../../modules/role"

  name = "test-assumable-role-service-with-attachments-no-inline"
  assume_policy_trusted_role_services = [
    "backup.amazonaws.com"
  ]

  role_policy_attachments = [
    "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup",
    "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
  ]

  default_inline_policy_actions = []

  tags = {
    "foo" = "bar"
  }
}

##########################################################
# IAM assumable role for admin with MFA
##########################################################
module "iam_assumable_role_admin_with_mfa" {
  source = "../../modules/role"

  name = "test-assumable-admin-role-with-mfa"
  assume_policy_trusted_role_arns = [
    "arn:aws:iam::${local.dev_account_id}:root",
  ]

  attach_admin_policy = true
  role_requires_mfa   = true

  tags = {
    "foo" = "bar"
  }
}

##########################################################
# IAM assumable role for admin with custom inline policy with condition
##########################################################
module "iam_assumable_role_with_inline_policy_with_condition" {
  source = "../../modules/role"

  name = "test-assumable-admin-role-with-inline-policy-with-coondition"
  assume_policy_trusted_role_services = [
    "backup.amazonaws.com"
  ]

  role_policy_attachments = [
    "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup",
    "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
  ]

  default_inline_policy_actions = []

  iam_policies = {
    "TheThingBrettWants" = {
      Actions = [
        "iam:PassRole",
      ]
      Resources = ["arn:aws:iam::*:role/*AwsBackup*"]
      Effect    = "Allow"
      Condition = {
        Test     = "StringEquals"
        Variable = "iam:PassedToService"
        Values   = ["backup.amazonaws.com", "restore-testing.backup.amazonaws.com"]
      }
    }
  }

  tags = {
    "foo" = "bar"
  }
}

##########################################################
# IAM assumable role for admin with custom inline policy with condition
##########################################################
module "iam_assumable_role_with_should_ignore_inline_policy" {
  source = "../../modules/role"

  name = "should-ignore-inline-policy"
  assume_policy_trusted_role_services = [
    "backup.amazonaws.com"
  ]

  role_policy_attachments = [
    "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup",
    "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
  ]

  include_inline_policy = false

  iam_policies = {
    "TheThingBrettWants" = {
      Actions = [
        "iam:PassRole",
      ]
      Resources = ["arn:aws:iam::*:role/*AwsBackup*"]
      Effect    = "Allow"
      Condition = {
        Test     = "StringEquals"
        Variable = "iam:PassedToService"
        Values   = ["backup.amazonaws.com", "restore-testing.backup.amazonaws.com"]
      }
    }
  }

  tags = {
    "foo" = "bar"
  }
}

##########################################################
# IAM assumable role for admin with custom inline policy
##########################################################
module "iam_assumable_role_with_inline_policy" {
  source = "../../modules/role"

  name = "test-assumable-admin-role-with-inline-policy"
  assume_policy_trusted_role_arns = [
    "arn:aws:iam::${local.dev_account_id}:root",
  ]

  iam_policies = {
    "AllowS3Access" = {
      Actions = [
        "s3:ListBucket",
        "s3:GetBucketLocation",
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:PutObjectAcl",
        "s3:GetObjectAcl"
      ]
      Resources = ["*"]
      Effect    = "Allow"
    }
  }

  tags = {
    "foo" = "bar"
  }
}

##########################################################
# IAM assumable role for admin cross account for security
##########################################################
module "iam_assumable_role_admin_cross_account" {
  source = "../../modules/role"

  name = "test-assumable-admin-role-cross-account"
  assume_policy_trusted_role_arns = [
    "arn:aws:iam::${local.security_account_id}:root",
  ]

  attach_admin_policy = true

  tags = {
    "foo" = "bar"
  }
}
