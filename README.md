# docker-sidekiq-web

A Docker image to run a stand-alone instance of the Sidekiq UI.

Updated to GoodCity versions of Sidekiq and ruby.

Forked from https://github.com/aschzero/docker-sidekiq-web
Original Docker Hub Repo: https://hub.docker.com/r/aschzero/sidekiq-web/

# Functionality

* Uses alpine ruby for the base image
* Uses most recent versions of required gems
* Removed username / password (we use Azure AD instead)

# Usage

## Building and Pushing

```
docker build -t sidekiq-web .
docker run \
  -p 3030:80 \
  -e REDIS_URL=redis://host:6379 \
  sidekiq-web
docker push <container registry> sidekiq-web:latest
```

## Deployment

Push `sidekiq-web:latest` or `sidekiq-web:production` to our Azure Container Registry in order to automatically deploy the app.

```
docker build -t sidekiq-web .
docker tag sidekiq-web <registry name>.azurecr.io/sidekiq-web:latest
docker push <registry name>.azurecr.io/goodcity/sidekiq-web
```

## Docker Compose

Example compose file:

```
version: '3'
services:
  sidekiq_web:
    image: sidekiq-web
    environment:
      REDIS_URL: redis://host:6379
    ports:
      - 3030:80
```