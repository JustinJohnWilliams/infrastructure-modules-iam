provider "aws" {
  region = "us-west-2"
}

##########################################################
# IAM Policy
##########################################################
module "iam_policy" {
  source = "../../modules/policy"

  name = "test-iam-policy"

  iam_policies = {
    "AllowS3" = {
      Effect    = "Allow",
      Actions   = ["s3:*"]
      Resources = ["*"]
    }
  }

  tags = {
    "foo" = "bar"
  }
}

##########################################################
# IAM Policy doc only
##########################################################
module "iam_policy_doc_only" {
  source = "../../modules/policy"

  name          = "test-iam-policy-doc-only"
  create_policy = false

  iam_policies = {
    "AllowS3" = {
      Effect    = "Allow",
      Actions   = ["s3:*"]
      Resources = ["*"]
    }
  }

  tags = {
    "foo" = "bar"
  }
}
