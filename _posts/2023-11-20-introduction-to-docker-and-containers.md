---
layout: post
title: "Introduction To Docker And Containers"
date: 2023-11-20 15:42:02 +0000
categories: ""
tags: ""
image:
  path: ""
  lqip: ""
---
***whatever you are be a good one ~ Abraham Lincoln***


## Parts 1
### About Docker
Docker is an open platform to build, ship and run distributed applications
- Escape dependency hell
- Onboard developers and contributors rapidly
- Implement reliable CI easily

### Install Docker

[view Docker docs](https://docs.docker.com/engine/install/)

### Our first containers

`docker run -it ubuntu`

the flags  `-i` is for interactive mode, `-t` : is for terminal

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

#### What is a layer
#### Various image namespaces
#### Searching and downloading images
#### Image tags and how to use them

building docker images
Building docker images
Advanced Dockerfiles
About dockerhub

## Part 2
naming and inspecting containers
Introduction to container networking
container network model
connecting containers with links
Ambassadors
Local Develpment Workflow with Docker
Working with volumes
Compose for development stacks


