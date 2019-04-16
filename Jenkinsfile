pipeline {
    agent none
    stages {
        stage('Run Build') {
            agent { label 'general' }
            steps {
                echo 'Running Build'
                sleep 60
                echo 'docker build -t gitsha .'
            }
        }
        stage('Run Tests') {
            agent { label 'general' }
            steps {
                echo 'Running Tests'
                sleep 3
                echo 'docker run blah tests'
            }
        }
        stage('Run Plan') {
            agent { label 'terraform' }
            steps {
                echo 'Running Terraform Plan'
                echo 'terraform plan'
                sh 'make plan'
            }
        }
        stage('Run Deploy (Apply)') {
            agent { label 'terraform' }
            input {
                message "Should we deploy?"
                ok "Yes, deploy!"
            }
            steps {
                echo 'Running Apply'
                echo 'terraform apply'
                sh 'make apply'
            }
        }
    }
}
