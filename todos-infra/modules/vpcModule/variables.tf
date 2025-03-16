variable "project_name" {
  type        = string
  description = "Project name for resource tagging"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}

