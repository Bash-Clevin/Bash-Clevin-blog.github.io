---
layout: post
title: "Automate Everything With Ansible"
date: 2023-11-15 11:16:53 +0000
categories: automation
tags: ansible automate linux
image:
  path: "/assets/img/headers/automate-with-everything-with-ansible-171198.webp"
  lqip: data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAf/AABEIAAYACgMBEQACEQEDEQH/xAGiAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgsQAAIBAwMCBAMFBQQEAAABfQECAwAEEQUSITFBBhNRYQcicRQygZGhCCNCscEVUtHwJDNicoIJChYXGBkaJSYnKCkqNDU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6g4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2drh4uPk5ebn6Onq8fLz9PX29/j5+gEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoLEQACAQIEBAMEBwUEBAABAncAAQIDEQQFITEGEkFRB2FxEyIygQgUQpGhscEJIzNS8BVictEKFiQ04SXxFxgZGiYnKCkqNTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqCg4SFhoeIiYqSk5SVlpeYmZqio6Slpqeoqaqys7S1tre4ubrCw8TFxsfIycrS09TV1tfY2dri4+Tl5ufo6ery8/T19vf4+fr/2gAMAwEAAhEDEQA/APmv4n+MotQ0W58S3unRTzSW1q2kaEq/2fp01h4b1m51y50rXNW0ObR9Ym0+SwvdB0K1jg3Xdtaf2i2l6hoQ07R4WyzHhDjjPuFOHOCsvyzw2qZ/V4ZqeK3iBnWJhmmU5Nn3DOV4vB4HL6WHyHCZTmtSvxTm2VfXY5xCpmWW5Zhaz9hSxmZUcWquXaZNx34cz8Q8+8FuIaHGWe8DcXZXDw64Wy7F4PKZS4d4yrY58NYzOHPC53l1Onk8eI4xzXBTo0MTjMPRjQxn1H65h6uGxvAt8b5dZZtYh8M+G9Nh1VjqUWnaVoNrpel6fHfH7VHZabpi3V4unafarKILOxW7ultLeOO3FxOI/Nb+Ucw4X8JI4/HRznBcY0M3jjMTHNaGS1cgeT0cyVaax1LKXiMJh8Q8sp4r2sMA69ChW+qql7WjTnzQj/fmS4908nymnkuByueTwyzAQymeb4OU82nlscLSWAlmk8PiJYeeYywqpPGyoSlRliXVdJuDiz//2Q==
---

***[Photo by Digital Buggu]( https://www.pexels.com/photo/colorful-toothed-wheels-171198/)***

## Install
have linux environment or wsl when using windows
[Ansible install doc](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu)

local machine
``` bash
apt update -y
apt install -y software-properties-common
add-apt-repository --yes --update ppa:ansible/ansible
apt install -y ansible

ansible --version #check ansible version
```

for automatic builds using [docker-compose](https://gist.github.com/Bash-Clevin/a82645d5bcf82e70ccd7b121ef4b49a6) 

## Automate
## Repeat
