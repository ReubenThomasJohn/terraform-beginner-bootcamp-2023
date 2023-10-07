variable "user_uuid" {
  description = "User UUID"
  type        = string

  validation {
    condition     = can(regex("^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$", var.user_uuid))
    error_message = "User UUID must be in the format of a UUID (e.g., 123e4567-e89b-12d3-a456-426655440000)"
  }
}

variable "bucket_name" {
  type        = string
  description = "Name of the AWS S3 bucket"
  # validation {
  #   condition     = regex("^([a-z0-9.-]+)$", var.bucket_name)
  #   error_message = "Invalid bucket name. The name must consist of lowercase letters, numbers, hyphens, and periods, and must start and end with a lowercase letter or number."
  # }
}

variable "index_html_filepath" {
  type        = string
  description = "Filepath to the index HTML file"
  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "The specified index HTML file does not exist."
  }
}

variable "error_html_filepath" {
  type        = string
  description = "Filepath to the error HTML file"
  validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The specified index HTML file does not exist."
  }
}