pipeline {
    agent any

    environment {
        REPO_URL = 'git@github.com:pjoter1906/snakegame-gui.git' /* Fork repo */
        BRANCH = 'master'  
        IMAGE_NAME = 'snakegame'
        TEST_IMAGE_NAME = 'snakegame-test'
    }

    stages {
        stage('Checkout Code from Fork') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: "*/${BRANCH}"]],
                    userRemoteConfigs: [[
                        url: REPO_URL,
                        credentialsId: 'github-ssh-key' // Klucz SSH do repozytorium
                    ]]
                ])
            }
        }

        stage('Build') {
            steps {
                script {
                    echo "Building application image from fork..."
                    sh "docker build -t ${IMAGE_NAME} -f Dockerfile ."
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    echo "Running tests using the built image from fork..."
                    sh "docker build -t ${TEST_IMAGE_NAME} -f Dockerfile.test ."
                    sh "docker run --rm --network=host ${TEST_IMAGE_NAME}"
                }
            }
        }
    }

    post {
        always {
            script {
                echo "Cleaning up old images..."
                sh "docker rmi -f ${IMAGE_NAME} ${TEST_IMAGE_NAME} || true"
            }
        }
    }
}

