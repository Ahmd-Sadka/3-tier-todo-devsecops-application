terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
     tls = {
      source = "hashicorp/tls"  # Specifies the TLS provider source and version
      version = "~> 3.0"  # Uses version 3.x of the TLS provider
    }
    kubernetes = {
      source = "hashicorp/kubernetes"  # Specifies the Kubernetes provider source and version
      version = "~> 2.0"  # Uses version 2.x of the Kubernetes provider
    }
    helm = {
      source = "hashicorp/helm"  # Specifies the Helm provider source and version
      version = "~> 2.0"  # Uses version 2.x of the Helm provider
    }
  }



    #   backend "s3" {
    #     bucket         = "application-registry-bea9"
    #     key            = "global/terraform.tfstate"
    #     region         = "us-east-1"
    # #   #encrypt        = true
    # #   #dynamodb_table = module.terraform_backend.dynamodb_table_name
    #   }
 
}

provider "aws" {
    region = "us-east-1"
}

provider "kubernetes" {
  host                   = module.eksModule.eks_cluster_endpoint  # Specifies the Kubernetes cluster endpoint
  cluster_ca_certificate = base64decode(module.eksModule.eks_cluster_certificate_authority)  # Decodes and sets the cluster CA certificate

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"  # Specifies the API version for the exec plugin
    command     = "aws"  # Specifies the command to execute for authentication
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eksModule.eks_cluster_name]  # Specifies the arguments for the command
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eksModule.eks_cluster_endpoint  # Specifies the Kubernetes cluster endpoint for Helm
    cluster_ca_certificate = base64decode(module.eksModule.eks_cluster_certificate_authority)  # Decodes and sets the cluster CA certificate for Helm

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"  # Specifies the API version for the exec plugin
      command     = "aws"  # Specifies the command to execute for authentication
      # This requires the awscli to be installed locally where Terraform is executed
      args = ["eks", "get-token", "--cluster-name", module.eksModule.eks_cluster_name]  # Specifies the arguments for the command
    }
  }
}
