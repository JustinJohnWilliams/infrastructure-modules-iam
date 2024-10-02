# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters, they should be provided by the parent terragrunt config
# ---------------------------------------------------------------------------------------------------------------------
variable "name" {
  description = "The name of your IAM Policy"
  type        = string
}

variable "iam_policies" {
  description = "The iam policies to add to the policy doc"
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
}

variable "tags" {
  type = map(any)
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# You must provide a value for each of these parameters, they should be provided by the parent terragrunt config
# ---------------------------------------------------------------------------------------------------------------------
variable "name_prefix" {
  description = "IAM policy name prefix"
  type        = string
  default     = null
}

variable "path" {
  description = "The path of the policy in IAM"
  type        = string
  default     = "/"
}

variable "description" {
  description = "The description of the policy"
  type        = string
  default     = null
}

variable "create_policy" {
  description = "Whether to create the IAM policy. Make this `false` if you just want the json doc out"
  type        = bool
  default     = true
}
