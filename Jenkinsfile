pipeline   {
    agent any

    environment {
    // Docker and ECR settings
    DOCKER_REGISTRY = "a7md12"              // e.g., public.ecr.aws/i5a7b8h3/image-name
    FRONT_IMAGE      = "${DOCKER_REGISTRY}/todo-web"
    DOCKER_LOGIN_CREDS = credentials('docker_credentials')
    
    // GitHub settings
    GITHUB_CREDS    = credentials('github')
    GITHUB_REPO     = "3-tier-todo-devsecops-application"            
    GITHUB_BRANCH   = "main"          // e.g., feature/backend
    DEPLOYMENT_FILE = "Charts/appChart/values.yaml"
    WEBHOOK_ID      = "516307081"
    
    // SonarQube settings (ensure SonarQube scanner is installed in the agent image)
    SONARQUBE_SERVER = "" // Replace with your SonarQube server URL
    // Optionally, set SONARQUBE_SCANNER_OPTS if required

    // Trivy settings (we'll run Trivy using its Docker image)
    TRIVY_IMAGE     = "aquasec/trivy:latest"
    
    // Kubernetes namespace for deployment
    K8S_NAMESPACE   = "default"           
  }
    stages {
        
    }
}