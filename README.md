# Docker network

Composes Docker containers behind an Nginx reverse proxy backed by
auto-renewing TLS certificates provided by Certbot.

## Components

### Nginx reverse proxy backed by Certbot

TLS certificate configuration via Certbot should only be done on the actual AWS
EC2 virtual machine to support HTTPS. All local development and testing should
be done via simple HTTP. See [here](./certbot/certbot.md) for further
information.

### Nginx website [beale.ga](https://beale.ga)

The primary web app privded behind the Nginx reverse proxy is the
[beale.ga](https://beale.ga) website. DNS management can be handled by logging
into the admin Google account on [freenom.com](https://freenom.com).

### Jenkins

Another web app provided behind the Nginx revers proxy is a Jenkins server. The
current primary purpopse of this Jenkins instance is to provide continuous
integration and deployment for the [beale.ga](https://beale.ga) Nginx website.
Access is gated behind an admin username and password.

All configuration changes made through the Jenkins web app will be saved in the
gitignored [`./data/jenkins/`](./data/jenkins/) directory. For example, when
you first run Jenkins, you should create an admin user and restrict access to
logged-in users for future sessions.

### AWS EC2 server

- AWS (US East, Ohio and North Virginia)
    - EC2 virtual machine: Ubuntu 20.04.1 LTS
    - Elastic IP address
    - EC2 security group allowing inbound ports 22, 80, 443 (and 9090 for Jenkins)
    - IAM roles: ec2-admin, deploy, and pipeline
    - IAM github user with specific github-codedeploy policy
    - CodeDeploy
    - CodePipeline
- GitHub
- Jenkins
- Docker containerized Nginx webserver

## Dev testing [beale.ga](https://beale.ga)

1. [Install docker-compose](https://docs.docker.com/compose/install/#install-compose)

2. Clone this repository: `git clone https://github.com/JFTung/docker-network.git`

3. Change to the `beale` directory and bring up the server:

        cd beale
        sudo docker-compose up

4. Connect to `http://localhost:8080` and test your changes

5. Bring down the server:

        sudo docker-compose down

## Prod installation

This section is only relevant for admins of the [beale.ga](https://beale.ga)
and [jenkins.beale.ga](https://jenkins.beale.ga) websites.

### Docker installation

Install both [Docker](https://docs.docker.com) and
[Docker Compose](https://docs.docker.com/compose). Follow the relevant
procedures for your machine and operating system.

Ensure Docker is up and running. Consider having Docker autostart on your dev
machine's turn, e.g. for Linux `sudo systemctl enable docker`. The AWS EC2 prod
machine must have this enabled.

### Repository setup

1. Clone this repository: `git clone https://github.com/JFTung/docker-network.git`

2. Build the custom `jenkins-host` Docker image:

        cd jenkins
        docker build -t jenkins-host .
        cd ..

3. Run the Let's Encrypt / Certbot init script:

        sudo ./certbot/init-letsencrypt.sh

4. Restart the server. This server will automatically restart whenever it is
   brought down (including when the machine turns) unless you explicitly stop
   it via commands like `sudo docker-compose down` or `sudo docker stop
   <container name>`

        sudo docker-compose down
        sudo docker-compose up
