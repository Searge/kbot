pipeline {
    agent any
    parameters {

        choice(name: 'OS', choices: ['linux', 'darwin', 'windows'], description: 'Pick OS')
        choice(name: 'ARCH', choices: ['amd64', 'arm64'], description: 'Pick ARCH')

    }
    stages {
        stage('Example') {
            steps {
                echo "Build for platform ${params.OS}"
                echo "Build for arch: ${params.ARCH}"

            }
        }

        stage('Test code') {
            steps {
                echo 'Perform testing...'
                sh 'make test'
            }
        }

        stage('Build image') {
            steps {
                echo 'Building docker image...'
                sh 'make image'
            }
        }

        stage('Push image') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub') {
                        echo 'Pushing docker image...'
                        sh 'docker-push'
                    }
                }
            }
        }

    }
}
