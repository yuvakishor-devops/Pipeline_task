pipeline {
    agent any

    environment {
	WORK_DIR        = "${env.WORKSPACE}"
        IMAGE_NAME      = "my-netflix-app"
        IMAGE_TAG       = "v1.0"
        CONTAINER_NAME  = "my-netflix-container"
        HOST_PORT       = "5000"
        APP_PORT        = "5000"
        DOCKERHUB_REPO  = "yuvakishor"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'feature', url: 'https://github.com/yuvakishor-devops/Pipeline_task.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Lint') {
            steps {
                sh 'npm run lint'
            }
        }

        stage('Test') {
            steps {
                sh 'npm test -- --watchAll=false'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker rmi -f ${DOCKERHUB_REPO}/${IMAGE_NAME}:${IMAGE_TAG} || true
                docker build -t ${DOCKERHUB_REPO}/${IMAGE_NAME}:${IMAGE_TAG} .
                '''
            }
        }

        stage('Run Docker Container (Local Test)') {
            steps {
                sh '''
                docker rm -f ${CONTAINER_NAME} || true
                docker run -itd --name ${CONTAINER_NAME} -p ${HOST_PORT}:${APP_PORT} ${IMAGE_NAME}:${IMAGE_TAG}
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub_creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${DOCKERHUB_REPO}/${IMAGE_NAME}:${IMAGE_TAG}
                    docker push ${DOCKERHUB_REPO}/${IMAGE_NAME}:${IMAGE_TAG}
                    docker logout
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
