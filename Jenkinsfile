pipeline {
    agent any

    tools {
        nodejs 'node'
    }
    
    environment {
    // Docker & ECR Configuration
    DOCKER_REGISTRY = "a7md12" // e.g., public.ecr.aws/yourorg/your-app
    IMAGE_NAME = "${DOCKER_REGISTRY}/todo-web"
    DOCKER_CREDENTIALS = credentials('dockerhub') // Store in Jenkins credentials

    // GitHub Configuration
    GITHUB_CREDS = credentials('github') // Username/password for Git operations
    GITHUB_REPO = "3-tier-todo-devsecops-application" // Adjust to your repo

    // SonarQube Configuration
    SCANNER_HOME = tool 'sonarqube-scanner' // Adjust to your SonarQube scanner installation name

    // Trivy Configuration
    TRIVY_IMAGE = "aquasec/trivy:latest"

    // Kubernetes/ArgoCD Configuration
    K8S_NAMESPACE = "default"
    DEPLOYMENT_MANIFESTS = "Charts/appChart/values.yaml" // Directory for manifests

    // Slack Configuration
    SLACK_CHANNEL = "#alerts"
  }

  stages{
      stage('Checkout') {
      steps {
        echo "Checking out branch ${env.BRANCH_NAME} from GitHub..."
        // Multibranch Pipeline automatically picks the branch
        git url: "https://github.com/Ahmd-Sadka/${GITHUB_REPO}.git", branch: "${env.BRANCH_NAME}", credentialsId: 'github'
      }
  }

  stage('Build & Test') {
      steps {
        dir('./3tier-nodejs/frontend') {    
            echo "Using Node.js version: ${env.NODE_VERSION}"
            echo "Installing dependencies and building React application..."
            sh 'npm install' // Install dependencies
            sh 'npm run build' // Build the React app
            sh 'npm test -- --coverage || true' // Run tests with coverage (optional if tests aren't set up)
        }
      }
    }

    stage('sonarqube analysis') {
      steps {
        echo "Running SonarQube analysis..."
        sh 'echo ${SCANNER_HOME}'
       
          sh """
          ${SCANNER_HOME}/bin/sonar-scanner \
          -Dsonar.projectKey=3-tier-devsecops-todo-app \
          -Dsonar.sources=./3tier-nodejs/frontend/src/ \
          -Dsonar.host.url=http://k8s-sharedgroup-31b89e88b4-230287661.us-east-1.elb.amazonaws.com/quality \
          -Dsonar.token=sqp_a5837c74c179e7a6a1a254cd88962809d8f056e1
          """

    

      }
    }

    // stage('Build Docker Image') {
    //   steps {
    //     echo "Building Docker image..."
    //     sh "docker build -t ${IMAGE_NAME} ."
    //   }
    // }

        
        
}
}