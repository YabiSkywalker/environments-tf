pipeline {
    agent any

    environment {
        BUILD_VERSION                =         'v1.03'
        GIT_CREDENTIALS_ID           =         'YabiSkywalker'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: "main", url: "https://github.com/YabiSkywalker/environments-tf.git"
            }
        }

        stage('Initialize') {
            steps {
                dir('environments/dev') { // Use relative path
                    sh "terraform init"
                }"
            }
        }

        stage('Validate syntax') {
            steps {
                dir('environments/dev') { // Use relative path
                    sh "terraform validate"
                }
            }
        }

        stage('Plan') {
            steps {
                dir('environments/dev') { // Use relative path
                    sh "terraform plan"
                }
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful!"
        }
        failure {
            echo "❌ Deployment failed!"
        }
    }
}