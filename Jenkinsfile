pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = "dailam008/flutter_docker_app"
        DOCKER_CREDENTIALS_ID = "dockerhub_credentials"
        FLUTTER_APP_PORT = "8085"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/dailam008/flutter_docker_app.git'
            }
        }

        stage('Build Flutter Web') {
            steps {
                echo 'Building Flutter web project...'
                bat 'flutter build web'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                bat 'docker build -t %DOCKER_HUB_REPO%:latest .'
            }
        }

        stage('Login & Push to Docker Hub') {
            steps {
                echo 'Logging in and pushing Docker image...'
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", passwordVariable: 'DOCKERHUB_PASS', usernameVariable: 'DOCKERHUB_USER')]) {
                    bat '''
                    docker login -u %DOCKERHUB_USER% -p %DOCKERHUB_PASS%
                    docker push %DOCKER_HUB_REPO%:latest
                    '''
                }
            }
        }

        stage('Run Container') {
            steps {
                echo 'Running Docker container on port 8085...'
                bat '''
                docker stop flutter_web_app || exit 0
                docker rm flutter_web_app || exit 0
                docker run -d -p %FLUTTER_APP_PORT%:80 --name flutter_web_app %DOCKER_HUB_REPO%:latest
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Build and deployment successful!"
        }
        failure {
            echo "❌ Build or deployment failed!"
        }
    }
}
