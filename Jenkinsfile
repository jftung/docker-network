// NOTE: CURRENTLY UNUSED

pipeline {
    agent any
    stages {
        stage("Build") {
            steps {
                echo "Building"
                writeFile file: "/etc/nginx/html/test.txt", text: "Some Text"
            }
        }
        stage("Deploy") {
            when {
                branch "main"
            }
            steps {
                echo "Deploying"
                //sudo docker-compose restart
            }
        }
        stage("Bounce") {
            when {
                environment name: "CHANGE_ID", value: ""
            }
            steps {
                echo "Bouncing"
                //sudo docker-compose restart
            }
        }
    }
}
