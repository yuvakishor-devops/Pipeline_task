pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git  branch: 'feature', url: 'https://github.com/yuvakishor-devops/Pipeline_task.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Lint') {
            steps {
                sh 'npm run lint || true'
            }
        }

        stage('Test') {
            steps {
                sh 'npm test || true'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'podman build -t devops-app .'
            }
        }

        stage('Run Container') {
            steps {
                sh 'podman run -d -p 3000:3000 devops-app || true'
            }
        }
    }
}
