# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters, they should be provided by the parent terragrunt config
# ---------------------------------------------------------------------------------------------------------------------
variable "name" {
  description = "The name of your IAM Role"
  type        = string
}

variable "tags" {
  type = map(any)
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# You must provide a value for each of these parameters, they should be provided by the parent terragrunt config
# ---------------------------------------------------------------------------------------------------------------------
variable "inline_policy_name" {
  description = "Name of the inline policy"
  type        = string
  default     = ""
}

variable "iam_policies" {
  description = "The iam policies to add to the role"
  type = map(object({
    Actions   = list(string)
    Effect    = string
    Resources = list(string)
    Principal = optional(object({
      Type        = string,
      Identifiers = list(string)
    }))
    NotPrincipal = optional(object({
      Type        = string,
      Identifiers = list(string)
    }))
    Condition = optional(object({
      Test     = string,
      Variable = string,
      Values   = list(string)
    }))
  }))
  default = {}
}

variable "role_description" {
  description = "IAM Role description"
  type        = string
  default     = ""
}

variable "role_path" {
  description = "Path of IAM role"
  type        = string
  default     = "/"
}

variable "assume_policy_trusted_role_arns" {
  description = "ARNs of AWS entities who can assume these roles"
  type        = list(string)
  default     = []
}

variable "assume_policy_trusted_role_services" {
  description = "AWS Services that can assume these roles"
  type        = list(string)
  default     = []
}

variable "role_sts_externalid" {
  description = "STS ExternalId condition values to use with a role (when MFA is not required)"
  type        = any
  default     = []
}

variable "role_requires_mfa" {
  description = "Whether role requires MFA"
  type        = bool
  default     = false
}

variable "mfa_age" {
  description = "Max age of valid MFA (in seconds) for roles which require MFA"
  type        = number
  default     = 86400
}

variable "allow_self_assume_role" {
  description = "Determines whether to allow the role to be [assume itself](https://aws.amazon.com/blogs/security/announcing-an-update-to-iam-role-trust-policy-behavior/)"
  type        = bool
  default     = false
}

variable "assume_policy_actions" {
  description = "Trusted role actions for the assume role policy"
  type        = list(string)
  default     = ["sts:AssumeRole", "sts:TagSession"]
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = 3600
}

variable "force_detach_policies" {
  description = "Whether policies should be detached from this role when destroying"
  type        = bool
  default     = false
}

variable "role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for IAM role"
  type        = string
  default     = ""
}

variable "include_inline_policy" {
  description = "Whether or not to include an inline policy"
  type        = bool
  default     = true
}

variable "default_inline_policy_actions" {
  description = "The default inline policy actions to add to role"
  type        = list(string)
  default     = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents", "logs:DescribeLogGroups", "logs:DescribeLogStreams", "logs:AssociateKmsKey"]
}

variable "role_policy_attachments" {
  description = "List of ARNs of IAM policies to attach to IAM role"
  type        = list(string)
  default     = []
}

variable "attach_admin_policy" {
  description = "Whether to attach an admin policy to a role"
  type        = bool
  default     = false
}

variable "attach_poweruser_policy" {
  description = "Whether to attach a poweruser policy to a role"
  type        = bool
  default     = false
}

variable "attach_readonly_policy" {
  description = "Whether to attach a readonly policy to a role"
  type        = bool
  default     = false
}
