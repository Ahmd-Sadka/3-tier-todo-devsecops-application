resource "aws_key_pair" "pipeline" {
    
  key_name   = "pipelineKey"
  public_key = file(var.public_key_path)
  
}
# Compare this snippet from todos-infra/modules/pipelineModule/variables.tf:
# variable "public_key_path" {
#   type        = string    
#   default     = "./todos-infra/keys/pipelineKey.pub"
# }

