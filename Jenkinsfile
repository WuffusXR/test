pipeline {
    agent {
        label 'docker'
    }
    stages {
        stage("Clean workspace") {
            steps {
                script {
                    sh "ls"
                    deleteDir()
                    sh "ls"
                }
            }
        }
        stage('Checkout SCM') {
            steps {
                git branch: 'main', url: 'https://git.ruff.co.il/tom/otomai-docker.git'
            }
        }
        stage('Download Latest release') {
            steps {
                sh 'curl -LO https://github.com/dvtzr/otomai/releases/latest/download/Otomai-web.zip'
            }
        }
        stage('Create web game directory') {
            steps {
                sh 'mkdir ./game-data'
            }
        }
        stage('Unzip File') {
            steps {
                sh 'unzip -d game-data/ Otomai-web.zip'
            }
        }
        stage('Build Docker Image') {
            steps {
                dir('./') {
                    script {
                        // Define image name and registry details
                        def imageNameId = "git.ruff.co.il/tom/otomai-web:1.0.${env.BUILD_ID}"
                        def imageNameLatest = "git.ruff.co.il/tom/otomai-web:latest"
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
        stage('Clean Old Container') {
            steps {
                try {
                    sh 'docker stop otomai'
                    sh 'docker rm -rf otomai'
                } catch (err) {
                    // Ignore the error if the container doesn't exist
                    echo "Container 'otomai' doesn't exist. Skipping."
                }
            }
        }
        stage('Run new container') {
            steps {
                script {
                    // Define registry credentials and image name
                    def registryCredentialsId = 'a9635f55-73fb-4fdb-9f0a-19bc48033164'
                    def imageName = 'git.ruff.co.il/tom/otomai-web:latest'

                    // Login to registry
                    docker.withRegistry('https://git.ruff.co.il', registryCredentialsId) {

                        // Run container
                        docker.image(imageName).run('-p 10002:80 --name otomai')
                    }
                }
            }
        }
    }
}