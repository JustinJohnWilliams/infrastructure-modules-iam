# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# ---------------------------------------------------------------------------------------------------------------------
variable "name" {
  description = "The name of the service account"
  type        = string
}

variable "iam_policies" {
  description = "Map of the IAM Permissions the service account will need to access"
  type = map(object({
    Actions   = list(string),
    Effect    = string,
    Resources = list(string)
  }))
}

variable "default_tags" {
  description = "Default tags should be passed in from root terragrunt module (e.g. env, account, region, etc)"
  type        = map(any)
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable "tags" {
  type = map(any)
}
