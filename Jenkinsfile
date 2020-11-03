pipeline {
    agent any
    stages {
        stage("Build") {
            steps {
                echo "Building"
                sh "ls -la"
            }
        }
        stage("Deploy") {
            when {
                allOf {
                    environment name: "CHANGE_ID", value: ""
                    branch "main"
                }
            }
            steps {
                echo "Deploying"
                sh "ls"
                //sudo docker-compose restart
            }
        }
        stage("Bounce") {
            when {
                allOf {
                    environment name: "CHANGE_ID", value: ""
                    branch "main"
                }
            }
            steps {
                echo "Bouncing"
                sh "ls"
                //sudo docker-compose restart
            }
        }
    }
}
