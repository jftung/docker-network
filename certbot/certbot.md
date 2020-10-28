# Boilerplate for nginx with Let’s Encrypt on docker-compose

> This is a fork of [this original repository](https://github.com/wmnnd/nginx-certbot), which is accompanied by a [step-by-step guide on how to set up nginx and Let’s Encrypt with Docker](https://medium.com/@pentacent/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71).

`init-letsencrypt.sh` fetches and ensures the renewal of a Let’s Encrypt
certificate for one or multiple domains in a docker-compose setup with nginx.
This is useful when you need to set up nginx as a reverse proxy for an
application.

## Installation

1. [Install docker-compose](https://docs.docker.com/compose/install/#install-compose)

2. Clone this repository: `git clone https://github.com/JFTung/docker-network.git`

3. Modify configuration:
    - Add domains and email addresses to `init-letsencrypt.sh`
    - Replace all occurrences of `example.org` with your primary domain (the
      first one you added to `init-letsencrypt.sh`) in all `nginx/*.conf` files

4. Run the init script:

        sudo ./certbot/init-letsencrypt.sh

5. Run the server. This server will automatically restart whenever it is
   brought down (including when the machine turns) unless you explicitly stop
   it via `sudo docker stop <container name>`

        sudo docker-compose up
