pipeline {
    agent {
        label 'docker'
    }
    stages {
        stage('Download Latest release') {
            steps {
                sh 'wget -O latest.zip https://objects.githubusercontent.com/github-production-release-asset-2e65be/864431154/d6f9dd9b-7d0d-4721-aa57-109d70e8a356?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=releaseassetproduction%2F20241004%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241004T153841Z&X-Amz-Expires=300&X-Amz-Signature=86575f6cfc7e6166f1a7fa92232f451a68aacae8a239e8993541f192d3d51d85&X-Amz-SignedHeaders=host&response-content-disposition=attachment%3B%20filename%3DOtomai-web.zip&response-content-type=application%2Foctet-stream'
            }
        }
        stage('Unzip File') {
            steps {
                sh 'unzip latest.zip'
            }
        }
        stage('Checkout SCM'){
            steps {
                git url: 'https://git.ruff.co.il/tom/otomai-docker.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                dir('otomai-docker') {
                    script {
                        // Define image name and registry details
                        def imageNameId = "git.ruff.co.il/tom/otomai-docker:${env.BUILD_ID}"
                        def imageNameLatest = "git.ruff.co.il/tom/otomai-docker:latest"
                        def registryCredentialsId = 'a9635f55-73fb-4fdb-9f0a-19bc48033164'

                        // Login to the Docker registry with credentials
                        docker.withRegistry('https://git.ruff.co.il', registryCredentialsId) {
                            // Build and push images using docker.build()
                            def customImageId = docker.build(imageNameId)
                            def customImageLatest = docker.build(imageNameLatest)

                            // Push image to registry
                            customImageId.push()
                            customImageLatest.push()
                        }
                    }
                }
            }
        }
    }
}