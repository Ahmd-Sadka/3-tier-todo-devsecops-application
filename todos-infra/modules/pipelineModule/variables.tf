variable "public_key_path" {
  type        = string
  description = "Name of the key pair for the pipeline"
  
}

variable "instance_type" {
  type        = string
  description = "Instance type for the EC2 instances"
  default = "t2.small"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID for the EC2 instances"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the EC2 instances"
}