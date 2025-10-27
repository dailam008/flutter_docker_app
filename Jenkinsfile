pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = "username_dockerhub_kamu/flutter_docker_app"
        DOCKER_CREDENTIALS_ID = "dockerhub_credentials"
        FLUTTER_APP_PORT = "8085"
        PATH = "C:\\src\\flutter\\bin;${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/dailam008/flutter_docker_app.git'
            }
        }

        stage('Check Flutter Version') {
            steps {
                echo 'Checking Flutter installation...'
                bat 'flutter --version'
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
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_CREDENTIALS_ID}") {
                        def app = docker.build("${DOCKER_HUB_REPO}:latest")
                        app.push()
                    }
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
