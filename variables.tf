variable "description" {
  description = "Description of the IAM role"
  type        = string
  default     = null
}

variable "assume_role_policy" {
  description = "JSON-encoded assume role (trust) policy document"
  type        = string

  validation {
    condition     = can(jsondecode(var.assume_role_policy))
    error_message = "assume_role_policy must be valid JSON."
  }
}

variable "path" {
  description = "Path for the IAM role"
  type        = string
  default     = "/"

  validation {
    condition     = can(regex("^/", var.path))
    error_message = "path must start with /."
  }
}

variable "max_session_duration" {
  description = "Maximum session duration in seconds (3600-43200)"
  type        = number
  default     = 3600

  validation {
    condition     = var.max_session_duration >= 3600 && var.max_session_duration <= 43200
    error_message = "max_session_duration must be between 3600 and 43200."
  }
}

variable "force_detach_policies" {
  description = "Whether to force detach policies before destroying the role"
  type        = bool
  default     = false
}
