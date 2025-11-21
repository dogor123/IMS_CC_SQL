pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-cred')
        IMAGE_NAME = "tebancito/ims_cc_mysql"
        BUILD_VERSION = "1.0.${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "=== Clonando repositorio IMS_CC_SQL ==="
                git branch: 'main', url: 'https://github.com/dogor123/IMS_CC_SQL'
            }
        }

        stage('Build Image') {
            steps {
                echo "=== Construyendo imagen MySQL personalizada ==="
                sh """
                    docker build -t ${IMAGE_NAME}:${BUILD_VERSION} .
                """
            }
        }

        stage('Test Image') {
            steps {
                echo "=== Probando contenedor MySQL ==="
                sh """
                    docker run -d --name mysql_test ${IMAGE_NAME}:${BUILD_VERSION}
                    sleep 15
                    docker logs mysql_test
                """
            }
            post {
                always {
                    sh "docker stop mysql_test || true"
                    sh "docker rm mysql_test || true"
                }
            }
        }

        stage('DockerHub Login & Push') {
            steps {
                sh """
                    echo ${DOCKERHUB_CREDENTIALS_PSW} | docker login \
                        -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin
                    docker push ${IMAGE_NAME}:${BUILD_VERSION}
                    docker tag ${IMAGE_NAME}:${BUILD_VERSION} ${IMAGE_NAME}:latest
                    docker push ${IMAGE_NAME}:latest
                """
            }
        }
    }

    post {
        always {
            sh 'docker system prune -f || true'
        }
        success {
            echo "✅ Imagen MySQL publicada exitosamente"
        }
        failure {
            echo "❌ Falló el pipeline de IMS_CC_SQL"
        }
    }
}
