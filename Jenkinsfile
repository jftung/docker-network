pipeline {
    agent any
    stages {
        stage('Checkout'){
            steps {
                sh 'ls -la'
            }
        }
        stage('Bounce Beale') {
            steps {
                sh 'ls'
                sudo docker-compose restart
            }
        }
    }
}
