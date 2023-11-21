---
layout: post
title: "Introduction To Docker And Containers"
date: 2023-11-20 15:42:02 +0000
categories: docker
tags: docker automate
image:
  path: /assets/img/headers/introduction-to-docker-and-containers.webp
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAcACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/AOQ8Yf8ABR34u+J/hzeeOPhz8G/BPwx8M6INR0ex0bXtST4haz4j8QXfhrV9T8GW5gsW8E6Ro+hX17ZW0eszy6hPqFvDb6lEiZubC8j+1xf0k+L8TjFl2WZjHJsnnk2KjiPqSq/2tHGTxEcPT5MXVwcoYaNHD08RWVXBr2/tKlL2dejUpcz+Ly/wH4Fo4LEyzXCY7NOKqOa5LisN7ZYaPDv9kVaOZTxvPCOJeLxWMeNoYOg6WKw8ML7B1J8mIVSVOn/Pdq/xL/aTvtW1O9u/ib8dTd3mo3t1df2f8SdC0yw+0XFzLNN9i06KaSLT7TzHb7NZRySR2sOyBHZYwx+Kn4p8TSnKVPjbiOFNyk4QlmObVZQg23GMqs66nUcY2TqT96bXNLVs/R6fh7wrSpwpz4P4YqSpwjCVR4KnFzlCKi5uMKKhFya5nGCUFe0UlY//2Q==
---

***[Photo by Chanaka](https://www.pexels.com/photo/cargo-container-lot-906494)***

***whatever you are be a good one ~ Abraham Lincoln***

### About Docker
Docker is an open platform to build, ship and run distributed applications
- Escape dependency hell
- Onboard developers and contributors rapidly
- Implement reliable CI easily

### Install Docker

[view Docker docs](https://docs.docker.com/engine/install/)

### Our first containers

`docker run -it ubuntu`

The flags  `-i` is for interactive mode, `-t` : is for terminal

Incase the `ubuntu` image is unavailable locally, docker will source it from public container registry, by default is dockerhub

sample output:

``` 
clevinbash@pop-os:~$ docker run -it ubuntu
Unable to find image 'ubuntu:latest' locally
latest: Pulling from library/ubuntu
aece8493d397: Pull complete 
Digest: sha256:2b7412e6465c3c7fc5bb21d3e6f1917c167358449fecac8176c6e496e5c1f05f
Status: Downloaded newer image for ubuntu:latest
root@872f14919aa2:/# 
```

In the terminal session you can do normal distro based installations i.e 
`apt-get update` and `apt-get install <package>` i.e figlet

To exit the container type `exit` or `ctrl + D`

#### Background containers

`docker run -d <imageName>`

To check running containers: `docker ps`

To tail a container logs: `docker logs  --tail 1 --follow <containerId> or containeName`

To stop container `docker kill` or `docker stop`

#### Restarting and attaching to containers
Docker does not distinguish between background and foreground containers, from its pov all containers are the same.

Attach to a running container: `docker attach <containerId>`

> If you attach to a container running a [REPL](https://www.digitalocean.com/community/tutorials/what-is-repl) (Read Eval print loop) hit `Enter` to display the terminal
{: .prompt-info }


### Understanding docker images
#### What is an image
An image is a collection of files and some meta data, images are made of layers which can be updated, shared and reused independently. Each layer can add, change and remove files.

### building docker images
#### Automated builds with Dockefile
Dockerfile is a recipe for building a docker image.
- create an empty directory to hold your Dockerfile: `mkdir <myImage>`
- Inside your directory create the Dockerfile and paste this into the file:
  
  ```Dockerfile
  FROM ubuntu
  RUN apt-get update
  RUN apt-get install figlet
  ```
  
> The keywords i.e `FROM` can be in lowercase, but the standard is to use uppercase, for more information view [Dockerfile reference](https://docs.docker.com/engine/reference/builder/#dockerfile-reference) 
{: .prompt-tip }

- To build the image run: `docker build -t <imageName> <context>`
  ``` bash
  docker build -t figlet .
  ```
  The `-t` is a reference to the [tag](https://docs.docker.com/engine/reference/commandline/tag) of an image


#### Advanced Dockerfile
**Collapsing layers:** it is possible to execte multiple commands in a single step. Alway note that every single docker command will generate a new layer.

``` shell
RUN apt-get update \
  && apt-get install -y wget \
  && apt-get clean
```

**`EXPOSE`** instruction tells Docker which ports are to be published in an image, all port are private by default.

```Dockerfile
EXPOSE 8080
EXPOSE 80 443
EXPOSE 53/tcp 53/udp
```

**`COPY`** instruction adds files and contents from your host to the image.
```Dockerfile
COPY . /src
```
> You can only reference files and directories inside the [build context](https://docs.docker.com/build/building/context/#what-is-a-build-context)
{: .prompt-info }

**`ADD`** works like copy but with extra features.
 - It can get remotefiles 
  ```
  ADD http://www.example.com/web.jar /opt/
  ```
 - ADD will automatically unpack zip files and tar archives
 ```
  ADD ./assets.zip /var/ww/htdocs/assets/
 ```

**`VOLUME`** tells Docker that there will be persistent content
```
VOLUME /var/lib/mysql
```

**`WORKDIR`** sets the working directory for subsequent instructions. It also affects `CMD` and `ENTRYPOINT`, since it sets the working directory used when starting the container.
```
WORKDIR /src
```

**`ENV`** specifies environment variables that should be set in any container launched from the image.
```
ENV WEB_PORT 8080
```
You can also overwride the environmet variables when running docker run

```shell
docker run -e WEB_PORT=8000 ...
```

## Naming and inspecting containers

Container names must be unique

To inspect an image: `docker inspect <imageName>`
Example using go template engine:


{% raw %}
```shell
docker inspect --format '{{ .State.Running }}' <ContainerName>
```
{% endraw %}


{% include embed/youtube.html id='ZVaRK10HBjo' %}

📺 [Watch Video](https://www.youtube.com/watch?v=ZVaRK10HBjo)
