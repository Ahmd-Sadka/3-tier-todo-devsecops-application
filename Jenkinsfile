pipeline {
    agent any

    tools {
        nodejs 'node'
    }
    
    environment {
    // Docker & ECR Configuration
    DOCKER_REGISTRY = "a7md12" // e.g., public.ecr.aws/yourorg/your-app
    IMAGE_NAME = "${DOCKER_REGISTRY}/3-tier-todo-devsecops-application-${env.BRANCH_NAME}" // Docker image name
    IMAGE_TAG = "${env.BUILD_ID}" // Use Jenkins build ID as the image tag
    DOCKER_CREDENTIALS = credentials('docker') // Store in Jenkins credentials

    // GitHub Configuration
    GITHUB_CREDS = credentials('github') // Username/password for Git operations
    GITHUB_REPO = "3-tier-todo-devsecops-application" // Adjust to your repo

    // SonarQube Configuration
    SCANNER_HOME = tool 'sonarqube-6.2' // Adjust to your SonarQube scanner installation name

    // Trivy Configuration
    TRIVY_IMAGE = "aquasec/trivy:latest"

    // Kubernetes/ArgoCD Configuration
    K8S_NAMESPACE = "default"
    VALUES_PATH = "Charts/appChart/values.yaml" // Directory for manifests

    // Slack Configuration
    SLACK_CHANNEL = "#alerts"
  }

  stages{

    // stage('Notify Start') {
    //   steps {
    //     script {
    //       slackSend(channel: "${env.SLACK_CHANNEL}", message: "Build started for branch ${env.BRANCH_NAME} in repo ${GITHUB_REPO}.")
    //     }
    //   }
    // }

    stage('Disable Webhook') {
    steps {
        script {
            sh '''
            curl -X PATCH -H "Authorization: token $GITHUB_CREDS_PSW" \
            https://api.github.com/repos/$GITHUB_CREDS_USR/$GITHUB_REPO/hooks/538212686 \
            -d '{"active": false}'
            '''
        }
    }
}
      stage('Checkout') {
      steps {
        echo "Checking out branch ${env.BRANCH_NAME} from GitHub..."
        // Multibranch Pipeline automatically picks the branch
        git url: "https://github.com/Ahmd-Sadka/${GITHUB_REPO}.git", branch: "${env.BRANCH_NAME}", credentialsId: 'github'
      }
  }



  // stage('Build & Test') {
  //     steps {
  //       dir('./3tier-nodejs/frontend') {    
  //           echo "Using Node.js version: ${env.NODE_VERSION}"
  //           echo "Installing dependencies and building React application..."
  //           sh 'npm install' // Install dependencies
  //           sh 'npm run build' // Build the React app
  //           sh 'npm test -- --coverage || true' // Run tests with coverage (optional if tests aren't set up)
  //       }
  //     }
  //   }

  //   stage('SAST with SonarQube') {
  //     steps {
  //       timeout(time: 60, unit: 'SECONDS') {
  //       withSonarQubeEnv('sonarqube') {
  //       echo "Running SonarQube analysis..."
  //       sh 'echo ${SCANNER_HOME}'
       
  //         sh """
  //         ${SCANNER_HOME}/bin/sonar-scanner \
  //         -Dsonar.projectKey=3-tier-devsecops-todo-app \
  //         -Dsonar.sources=./3tier-nodejs/frontend/src \
  //         -Dsonar.javascript.lcov.reportPaths=./3tier-nodejs/frontend/coverage/lcov.info \
  //         """
  //         }
  //       waitForQualityGate abortPipeline: true
  //       }   
  //     }
  //   }


    stage('Build Docker Image') {
      steps {
        dir('./3tier-nodejs/frontend') {
        echo "Building Docker image..."
        sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
      }
    }
    }
    stage('scaning and pushing docker image') {
      parallel {

        stage('Scan Docker Image with Trivy') {
          steps {
            echo "Scanning Docker image with Trivy..."
            sh """
            docker run --rm \
              -v /var/run/docker.sock:/var/run/docker.sock \
              -v /tmp:/tmp \
              ${TRIVY_IMAGE} image --quiet --exit-code 0 --severity HIGH,CRITICAL --format json --output trivy-report.json --ignore-unfixed ${IMAGE_NAME}:${IMAGE_TAG} > trivy-report.json
              """
            archiveArtifacts artifacts: 'trivy-report.json'
          }
        }


        stage("Push Docker Image") {
          steps {
            withCredentials([usernamePassword(credentialsId: 'docker', secretKeyVariable: 'DOCKER_CREDENTIALS_PSW', passwordVariable: 'DOCKER_CREDENTIALS_PSW', usernameVariable: 'DOCKER_CREDENTIALS_USR')]) {
            echo "Pushing Docker image to ECR or dockerhub..."
          //sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${DOCKER_REGISTRY}"
            sh "docker login -u ${DOCKER_CREDENTIALS_USR} -p ${DOCKER_CREDENTIALS_PSW}"
            sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
          }
        }
        }
      }
    }
    

    stage('Update Charts Values.yaml') {
      steps {
        echo "Updating Helm chart values.yaml with new image tag..."
        script {
          def valuesFile = readYaml file: "${VALUES_PATH}"
          valuesFile.frontend.image = "${IMAGE_NAME}:${IMAGE_TAG}"
          writeYaml file: "${VALUES_PATH}", data: valuesFile , overwrite: true
        }
      }
    }

    stage('Commit Changes') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'github', secretKeyVariable: 'GITHUB_CREDS_PSW', passwordVariable: 'GITHUB_CREDS_PSW', usernameVariable: 'GITHUB_CREDS_USR')]) {
        echo "Creating pull request for Helm chart update..."
        script {
          sh 'git config --global --add safe.directory $WORKSPACE'
          sh 'git add .'
          sh 'git commit -m "Update values.yaml with new image tag ${IMAGE_NAME}:${IMAGE_TAG}"'
          sh "git push origin ${env.BRANCH_NAME}"
        }
        }
      }
    }

    stage('Open Pull Request') {
      steps {
        echo "Opening pull request for Helm chart update..."

          sh """
          curl -X POST -H "Authorization: token ${GITHUB_CREDS}" \
            -H "Accept: application/vnd.github.v3+json" \
            -d '{"title":"Update Helm chart","head":"${env.BRANCH_NAME}","base":"main"}' \
            https://api.github.com/repos/Ahmd-Sadka/${GITHUB_REPO}/pulls
          """
        }
      }
      
    
     
        
}
}