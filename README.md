# Docker network

Composes Docker containers behind an Nginx reverse proxy backed by
auto-renewing TLS certificates provided by Certbot.

## Components

### Nginx reverse Proxy

TODO

### Certbot

TODO

### Jenkins

All configuration changes made through the Jenkins web app will be saved in the
gitignored `./data/jenkins/` directory. For example, when you first run
Jenkins, you should create an admin user and restrict access to logged-in
users for future sessions.

### Nginx website [beale.ga](https://beale.ga)

TODO

------------------------------------

# Beale Gaming Website

## Development and building

### Docker installation

Install both Docker and Docker Compose. Follow the relevant procedures for your
machine and operating system:

    - https://docs.docker.com
    - https://docs.docker.com/compose

Ensure Docker is up and running. Consider having Docker autostart on your dev
machine's turn: `sudo systemctl enable docker`. The AWS EC2 prod machine must
have this enabled.

### Dev testing

1. Switch to the `dev` directory and bring up the server:

        cd dev
        sudo docker-compose up

2. Connect to `http://localhost:8080` and test your changes

3. Bring down the server:

        sudo docker-compose down

## Tech stack

- AWS (US East, Ohio and North Virginia)
    - EC2 virtual machine: Ubuntu 20.04.1 LTS
    - Elastic IP address
    - EC2 security group allowing inbound ports 22, 80, 443 (and 9090 for Jenkins)
    - IAM roles: ec2-admin, deploy, and pipeline
    - IAM github user with specific github-codedeploy policy
        - Access key ID: AKIAT7UN7EOIQD2B5V6S
        - Secret access key: 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
    - CodeDeploy
    - CodePipeline
- GitHub TODO
    personal access token: 043b1741ed555ebad6048f86f739abed25103335
- Jenkins
- Docker containerized Nginx webserver

## Appendix

### Server configuration

Install AWS CodeDeploy and enable autostart on machine turn:

```
apt-get update
apt-get install -y ruby
wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/releases/codedeploy-agent_1.0-1.1597_all.deb
mkdir codedeploy-agent_1.0-1.1597_ubuntu20
dpkg-deb -R codedeploy-agent_1.0-1.1597_all.deb codedeploy-agent_1.0-1.1597_ubuntu20
sed 's/2.0/2.7/' -i ./codedeploy-agent_1.0-1.1597_ubuntu20/DEBIAN/control
dpkg-deb -b codedeploy-agent_1.0-1.1597_ubuntu20
sudo dpkg -i codedeploy-agent_1.0-1.1597_ubuntu20.deb
sudo systemctl start codedeploy-agent
sudo systemctl enable codedeploy-agent
TODO now disabled
```

### SSL certificate

This should only be done on the actual AWS EC2 virtual machine to support
HTTPS. All local development and testing should be done via simple HTTP. See
[this repository](https://github.com/JFTung/nginx-certbot) for further
information.

### DNS management

Log into the admin Google account on https://freenom.com.

------------------------------------

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

Ingore this section unless you are an admin of the [beale.ga](https://beale.ga)
or [jenkins.beale.ga](https://jenkins.beale.ga) websites.

### Docker installation

Install both [Docker](https://docs.docker.com) and
[Docker Compose](https://docs.docker.com/compose). Follow the relevant
procedures for your machine and operating system.

Ensure Docker is up and running. Consider having Docker autostart on your dev
machine's turn, e.g. for Linux `sudo systemctl enable docker`. The AWS EC2 prod
machine must have this enabled.

1. [Install docker-compose](https://docs.docker.com/compose/install/#install-compose)

2. Clone this repository: `git clone https://github.com/JFTung/docker-network.git`

3. Build the custom `jenkins-host` Docker image:

        cd jenkins
        docker build -t jenkins-host .
        cd ..

3. Run the Let's Encrypt / Certbot init script:

        sudo ./certbot/init-letsencrypt.sh

5. Run the server. This server will automatically restart whenever it is
   brought down (including when the machine turns) unless you explicitly stop
   it via `sudo docker stop <container name>`

        sudo docker-compose up
