pipeline {
    agent {
        label 'docker'
    }
    stages {
        stage('Download Latest release') {
            steps {
                sh 'curl -LO https://git.ruff.co.il/tom/otomai/releases/download/v1.0.1/Otomai-web.zip'
            }
        }
        stage('Unzip File') {
            steps {
                sh 'unzip Otomai-web.zip'
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