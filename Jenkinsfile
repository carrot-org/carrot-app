pipeline {
    agent {
        node {
            label 'general'
        }
    }
    stages {
        stage('Run Build') {
            steps {
                echo 'Running Build'
                sleep 3
                echo 'docker build -t gitsha .'
            }
        }
        stage('Run Tests') {
            steps {
                echo 'Running Tests'
                sleep 3
                echo 'docker run blah tests'
            }
        }
        stage('Run Plan') {
            steps {
                echo 'Running Terraform Plan'
                sleep 3
                echo 'terraform plan'
            }
        }
        stage('Run Deploy (Apply)') {
            input {
                message "Should we deploy?"
                ok "Yes, deploy!"
            }
            steps {
                echo 'Running Apply'
                sleep 3
                echo 'terraform apply'
            }
        }
    }
}
