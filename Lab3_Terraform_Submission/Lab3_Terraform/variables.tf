variable "project_name" {
  description = "Project name used in Docker container names."
  type        = string
  default     = "lab3"
}

variable "instance_count" {
  description = "Number of scalable web instances."
  type        = number
  default     = 2

  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 10
    error_message = "instance_count must be between 1 and 10."
  }
}

variable "base_port" {
  description = "First host port exposed by the containers."
  type        = number
  default     = 8081
}
