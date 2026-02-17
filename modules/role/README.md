# IAM Policy

Creates an IAM Policy with the provided policy statements

## Resources
| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_document.policy_doc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source (json) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of your IAM Policy | `string` | | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to IAM Policy | `map(any)` | | yes |
| <a name="input_iam_policies"></a> [iam\_policies](#input\_iam\_policies) | The iam policies to add to the policy doc | `map(object{})` | | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | IAM Policy name prefix | `string` | `null` | no |
| <a name="input_path"></a> [path](#input\_path) | Path of the policy in IAM | `string` | `"/"` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the policy | `string` | `null` | no |
| <a name="input_create_policy"></a> [create_policy](#input\_create\_policy) | Whether to create the IAM policy. Make this `false` if you just want the json doc out | `bool` | `true` | no |
