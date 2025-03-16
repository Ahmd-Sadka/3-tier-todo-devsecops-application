# modules/s3/variables.tf
variable "bucket_name" {
  type        = string
  description = "Unique S3 bucket name"
}

variable "enable_elb_logging" {
  type        = bool
  default     = false
  description = "Enable ELB access logging configuration"
}

variable "enable_backend" {
  type        = bool
  default     = false
  description = "Configure bucket as Terraform backend"
}



variable "force_destroy" {
  type        = bool
  default     = false
  description = "Allow bucket destruction even if not empty (DANGEROUS)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Resource tags"
}