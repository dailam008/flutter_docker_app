pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'flutter_docker_app'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/dailam008/flutter_docker_app.git'
            }
        }

        stage('Build Flutter Web') {
            steps {
                sh 'flutter clean'
                sh 'flutter build web'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker stop flutter_docker_app || true'
                sh 'docker rm flutter_docker_app || true'
                sh 'docker run -d -p 8085:80 --name flutter_docker_app ${DOCKER_IMAGE}:${DOCKER_TAG}'
            }
        }
    }
}
