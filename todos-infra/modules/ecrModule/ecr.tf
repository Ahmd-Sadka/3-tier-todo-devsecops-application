resource "aws_ecrpublic_repository" "frontend" {
    
  repository_name     = var.frontendRepository_name

  tags = {
    Name        = "frontend"
  }
}

resource "aws_ecrpublic_repository" "backend" {
    
  repository_name     = var.backendRepository_name

  tags = {
    Name        = "backend"
  }
}