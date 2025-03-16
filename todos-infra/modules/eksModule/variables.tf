variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs"
}

variable "key" {
  type        = string
  description = "Name of the key pair for the EC2 instances"
}

variable "security_group_id" {
  type        = string
  description = "ID of the security group"
}
