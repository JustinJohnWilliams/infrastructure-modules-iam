# IAM Role

Creates a single IAM role which can be assumbed by trusted resources (both internal and external), have in-line policies, or just attach to existing policies. You will need to provide either the `assume_policy_trusted_role_arns` or the `assume_policy_trusted_role_services` parameter to provide the role with at least one trusted resource that can assume it.

## Resources
| Name | Type |
|------|------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.poweruser](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.readonly](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source (json) |
| [aws_iam_policy_document.inline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source (json) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of your IAM Role | `string` | | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to IAM role resources | `map(any)` | | yes |
| <a name="input_inline_policy_name"></a> [inline\_policy\_name](#input\_inline\_policy\_name) | Name of the inline policy | `string` | `""` | no |
| <a name="input_iam_policies"></a> [iam\_policies](#input\_iam\_policies) | Additional IAM roles to add to the inline policy | `string` | `{}` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | IAM Role description | `string` | `""` | no |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | Path of IAM role | `string` | `"/"` | no |
| <a name="input_assume_policy_trusted_role_arns"></a> [assume\_policy\_trusted\_role\_arns](#input\_assume\_policy\_trusted\_role\_arns) | ARNs of AWS entities who can assume these roles | `list(string)` | `[]` | no |
| <a name="input_assume_policy_trusted_role_services"></a> [assume\_policy\_trusted\_role\_services](#input\_assume\_policy\_trusted\_role\_services) | AWS Services that can assume these roles | `list(string)` | `[]` | no |
| <a name="input_role_sts_externalid"></a> [role\_sts\_externalid](#input\_role\_sts\_externalid) | STS ExternalId condition values to use with a role (when MFA is not required) | `any` | `[]` | no |
| <a name="input_role_requires_mfa"></a> [role\_requires\_mfa](#input\_role\_requires\_mfa) | Whether role requires MFA | `bool` | `false` | no |
| <a name="input_mfa_age"></a> [mfa\_age](#input\_mfa\_age) | Max age of valid MFA (in seconds) for roles which require MFA | `number` | `86400` | no |
| <a name="input_allow_self_assume_role"></a> [allow\_self\_assume\_role](#input\_allow\_self\_assume\_role) | Determines whether to allow the role to be [assume itself](https://aws.amazon.com/blogs/security/announcing-an-update-to-iam-role-trust-policy-behavior/) | `bool` | `false` | no |
| <a name="input_assume_policy_actions"></a> [assume\_policy\_actions](#input\_assume\_policy\_actions) | Trusted role actions for the assume role policy | `list(string)` | `["sts:AssumeRole", "sts:TagSession"]` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `3600` | no |
| <a name="input_force_detach_policies"></a> [force\_detach\_policies](#input\_force\_detach\_policies) | Whether policies should be detached from this role when destroying | `bool` | `false` | no |
| <a name="input_role_permissions_boundary_arn"></a> [role\_permissions\_boundary\_arn](#input\_role\_permissions\_boundary\_arn) | Permissions boundary ARN to use for IAM role | `string` | `""` | no |
| <a name="input_include_inline_policy"></a> [include\_inline\_policy](#input\_include\_inline\_policy) | Whether or not to include an inline policy | `bool` | `true` | no |
| <a name="input_default_inline_policy_actions"></a> [default\_inline\_policy\_actions](#input\_default\_inline\_policy\_actions) | The default inline policy actions to add to role | `list(string)` | `["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents", "logs:DescribeLogGroups", "logs:DescribeLogStreams", "logs:AssociateKmsKey"]` | no |
| <a name="input_role_policy_attachments"></a> [role\_policy\_attachments](#input\_role\_policy\_attachments) | List of ARNs of IAM policies to attach to IAM role | `list(string)` | `[]` | no |
| <a name="input_attach_admin_policy"></a> [attach\_admin\_policy](#input\_attach\_admin\_policy) | Whether to attach an [admin](https://docs.aws.amazon.com/aws-managed-policy/latest/reference/AdministratorAccess.html) policy to a role | `bool` | `false` | no |
| <a name="input_attach_poweruser_policy"></a> [attach\_poweruser\_policy](#input\_attach\_poweruser\_policy) | Whether to attach a [poweruser](https://docs.aws.amazon.com/aws-managed-policy/latest/reference/PowerUserAccess.html) policy to a role | `bool` | `false` | no |
| <a name="input_attach_readonly_policy"></a> [attach\_readonly\_policy](#input\_attach\_readonly\_policy) | Whether to attach a [readonly](https://docs.aws.amazon.com/aws-managed-policy/latest/reference/ReadOnlyAccess.html) policy to a role | `bool` | `false` | no |
