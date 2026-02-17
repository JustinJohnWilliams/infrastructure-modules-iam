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

variable "tags" {
  type = map(any)
}
