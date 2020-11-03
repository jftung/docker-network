pipeline {
    agent any
    stages {
        stage("Build") {
            steps {
                echo "Building"
                sh "ls -la"
                writeFile file: "/etc/nginx/html/test.txt", text: "Some Text"
            }
        }
        stage("Deploy") {
            when {
                branch "main"
            }
            steps {
                echo "Deploying"
                sh "ls"
                //sudo docker-compose restart
            }
        }
        stage("Bounce") {
            when {
                environment name: "CHANGE_ID", value: ""
            }
            steps {
                echo "Bouncing"
                sh "ls"
                //sudo docker-compose restart
            }
        }
    }
}
