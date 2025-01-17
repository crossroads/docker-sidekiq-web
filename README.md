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
docker run -p 3030:3000 -e REDIS_URL=redis://172.17.0.4:6379/2 sidekiq-web
docker push <container registry> sidekiq-web:master
```

## Deployment

Push `sidekiq-web:master` or `sidekiq-web:live` to our Azure Container Registry in order to automatically deploy the app.

```
docker build -t sidekiq-web .
docker tag sidekiq-web <registry name>.azurecr.io/sidekiq-web:master
docker push <registry name>.azurecr.io/sidekiq-web
```

Alternatively, use Azure Container Registry to build and deploy the image.

```
az login
az acr build --registry <registry name> --image sidekiq-web:master .
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