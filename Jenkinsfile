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
    SONARQUBE_SERVER = "sonarqube" // Name configured in Jenkins
    SONAR_HOST_URL = "http://k8s-sharedgroup-31b89e88b4-1817630104.us-east-1.elb.amazonaws.com/quality" // Adjust to your SonarQube URL
    SONAR_TOKEN = credentials('sonarqube')

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
      environment {
        scannerHome = tool 'sonarqube';
        }
      steps {
        echo "Running SonarQube analysis..."
        withSonarQubeEnv("${SONARQUBE_SERVER}") {
          sh """
          ${scannerHome}/bin/sonar-scanner \
          -Dsonar.projectKey=${GITHUB_REPO} \
          -Dsonar.sources=./3tier-nodejs/frontend/src \
          -Dsonar.tests=./3tier-nodejs/frontend/src \
          -Dsonar.test.inclusions=**/*.test.js \
          -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info \
          -Dsonar.host.url=${SONAR_HOST_URL}
          """

        }
    

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