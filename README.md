# Docker network

Composes Docker containers behind an Nginx reverse proxy backed by
auto-renewing TLS certificates provided by Certbot.

## Components

### Nginx reverse proxy backed by Certbot

TLS certificate configuration via Certbot should only be done on the actual AWS
EC2 virtual machine to support HTTPS. All local development and testing should
be done via simple HTTP. Certificates and keys are saved in the gitignored
[`data/certbot/`](data/certbot/) directory. See [here](certbot/certbot.md)
for further information.

### Nginx website [beale.ga](https://beale.ga)

The primary web app provided behind the Nginx reverse proxy is the
[beale.ga](https://beale.ga) website. The entire
[`beale/html/`](beale/html/) directory is passed to a Docker volume, so
any new files can be placed there with no further configuration necessary. DNS
management can be handled by logging into the admin Google account on
[freenom.com](https://freenom.com).

### Jenkins

> **TODO** Integrate Jenkins with GitHub to automatically deploy new versions to
> the AWS EC2 prod server.

Another web app provided behind the Nginx reverse proxy is a Jenkins server
gated behind an admin username and password:
[jenkins.beale.ga](https://jenkins.beale.ga). The current primary purpose of
this Jenkins instance is to provide continuous integration and deployment for
the [beale.ga](https://beale.ga) Nginx website.

All configuration changes made through the Jenkins web app will be saved in the
gitignored [`data/jenkins/`](data/jenkins/) directory. For example, when
you first run Jenkins, you should create an admin user and restrict access to
logged-in users for future sessions.

### AWS EC2 server

- EC2 US East virtual machine: Ubuntu 20.04.1 LTS
- EC2 security group allowing inbound ports 22, 80, and 443
- IAM role: ec2-admin
- Elastic IP address

## Dev testing [beale.ga](https://beale.ga)

1.  Install both [Docker](https://docs.docker.com/get-docker/) and
    [Docker Compose](https://docs.docker.com/compose/install/). Follow the
    relevant procedures for your machine and operating system.

2.  Ensure Docker is up and running. Consider having Docker autostart on your
    dev machine's turn, e.g. for Linux `sudo systemctl enable docker`.

3.  Clone this repository: `git clone https://github.com/JFTung/docker-network.git`

4.  Change to the `beale` directory and bring up the server:

        cd beale
        sudo docker-compose up &

5.  Connect to `http://localhost:8080` and test your changes

6.  Bring down the server:

        sudo docker-compose down

## Dev linting

Install Prettier and ESLint (only necessary the first time):

        npm install

Run linters:

        ./node_modules/.bin/prettier -w * .github/ .eslintrc.json
        ./node_modules/.bin/eslint --fix beale/html/

You can safely ignore any Prettier errors about "No supported files were found
in the directory."

As an appendix, the npm [`package.json`](package.json),
[`package-lock.json`](package-lock.json), and
[`.eslintrc.json`](.eslintrc.json) files were originally generated via:

        npm init
        npm install eslint --save-dev
        npm install prettier --save-dev
        ./node_modules/.bin/eslint --init

## Prod continuous deployment

Jenkins will automatically build, deploy, and bounce everything when a pull
request is accepted. No admin actions are necessary, with one exception.

If [`jenkins/Dockerfile`](jenkins/Dockerfile) was modifed, rebuild the custom
`jenkins-host` Docker image and restart the network:

        cd jenkins
        docker build -t jenkins-host .
        cd ..
        sudo docker-compose restart &

## Prod first time setup

This section is only relevant for admins of the [beale.ga](https://beale.ga)
and [jenkins.beale.ga](https://jenkins.beale.ga) websites.

### Docker installation

Install both [Docker](https://docs.docker.com/get-docker/) and
[Docker Compose](https://docs.docker.com/compose/install/). Follow the relevant
procedures for your machine and operating system.

Ensure Docker is up and running. Enable autostart on the AWS EC2 prod machine
turn, i.e. `sudo systemctl enable docker`.

### Repository setup

1.  Clone this repository: `git clone https://github.com/JFTung/docker-network.git`

2.  Build the custom `jenkins-host` Docker image:

        cd jenkins
        docker build -t jenkins-host .
        cd ..

3.  Run the Let's Encrypt / Certbot init script:

        sudo ./certbot/init-letsencrypt.sh

4.  Restart the server. This server will automatically restart whenever it is
    brought down (including when the machine turns) unless you explicitly stop
    it via commands like `sudo docker-compose down` or `sudo docker stop <container name>`

         sudo docker-compose restart &
