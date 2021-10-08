# docker-sidekiq-web

A Docker image to run a stand-alone instance of the Sidekiq UI.

Updated to GoodCity versions of Sidekiq and ruby.

Docker Hub Repo: https://hub.docker.com/r/crossroads/sidekiq-web/

Forked from https://github.com/aschzero/docker-sidekiq-web
Original Docker Hub Repo: https://hub.docker.com/r/aschzero/sidekiq-web/

# Functionality

* Uses alpine ruby for the base image
* Uses most recent versions of required gems
* Removed username / password (we use Azure AD instead)

# Usage

## Simple Example


```
docker build -t sidekiq-web .
docker run \
  -p 3030:3030 \
  -e REDIS_URL=redis://host:6379 \
  sidekiq-web
```

## Docker Compose

Example compose file:

```
version: '3'
services:
  sidekiq_web:
    image: crossroads/sidekiq-web
    environment:
      REDIS_URL: redis://host:6379
    ports:
      - 3030:3030
```