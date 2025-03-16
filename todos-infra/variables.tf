variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
  
}

variable "project_name" {
  type        = string
  description = "Project name for resource tagging"
  
}

variable "public_key_path" {
  type        = string
  description = "Path to the public key for the pipeline"
  
}
