output "front_arn" {
  description = "Full ARN of the frontend repository"
  value       = aws_ecrpublic_repository.frontend.arn
}

output "back_arn" {
  description = "Full ARN of the backend repository"
  value       = aws_ecrpublic_repository.backend.arn
}

output "front_id" {
  description = "frontend The registry ID where the repository was created."
  value       = aws_ecrpublic_repository.frontend.registry_id
}

output "back_id" {
  description = "backend The registry ID where the repository was created."
  value       = aws_ecrpublic_repository.backend.registry_id
}

output "front_repository_uri" {
  description = "The URI of the frontend repository."
  value       = aws_ecrpublic_repository.frontend.repository_uri
}

output "backend_repository_uri" {
  description = "The URI of the backend repository."
  value       = aws_ecrpublic_repository.backend.repository_uri
}