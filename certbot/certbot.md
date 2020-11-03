# Boilerplate for Nginx with Let’s Encrypt on Docker Compose

> This is a fork of [this original repository](https://github.com/wmnnd/nginx-certbot), which is accompanied by a [step-by-step guide on how to set up Nginx and Let’s Encrypt with Docker](https://medium.com/@pentacent/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71).

[`init-letsencrypt.sh`](./init-letsencrypt.sh) fetches and ensures the renewal
of a Let’s Encrypt certificate for one or multiple domains in a docker-compose
setup with Nginx. This is useful when you need to set up Nginx as a reverse
proxy for an application.

## Installation

1.  [Install docker-compose](https://docs.docker.com/compose/install/#install-compose)

2.  Clone this repository: `git clone https://github.com/JFTung/docker-network.git`

3.  Modify configuration:

    - Add domains and email addresses to [`init-letsencrypt.sh`](./init-letsencrypt.sh)
    - Replace all occurrences of `example.org` with your primary domain (the
      first one you added to [`init-letsencrypt.sh`](./init-letsencrypt.sh)) in
      all [`nginx/*.conf`](../nginx/) files

4.  Run the init script:

        sudo ./certbot/init-letsencrypt.sh

5.  Run the server. This server will automatically restart whenever it is
    brought down (including when the machine turns) unless you explicitly stop
    it via `sudo docker stop <container name>`

         sudo docker-compose down
         sudo docker-compose up

## License

```
MIT License

Copyright (c) 2018 Philipp Schmieder

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
