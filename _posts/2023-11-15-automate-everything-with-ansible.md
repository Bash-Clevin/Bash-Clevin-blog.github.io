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


ansible automate copy public key to remote machines
```bash
for user in ansible root
 do
   for os in ubuntu centos
   do
     for instance in 1 2 3
     do
       sshpass -f password.txt ssh-copy-id -o StrictHostKeyChecking=no ${user}@${os}${instance}
    done
  done
done
```

try to ping the hosts:

`ansible -i,ubuntu1,ubuntu2,ubuntu3,centos1,centos2,centos3 all -m ping`


## Ansible configuration
To check ansible config file run `ansible --version` on the output check `config file`

Ansible config files based on priority
 1. `ANSIBLE_CONFIG` - environmental variable with a filename target example `export ANSIBLE_CONFIG=/home/ansible/myconfig.cfg`
 2. `./ansible.cfg`  - based on current directory
 3. `~/.ansible.cfg`  - hidden file in user home directory
 4. `/etc/ansible/ansible.cfg`  - provided through package or system installation of ansible

## Ansible inventories
Inventory is a file that defines the target hosts on which Ansible should run tasks on.

Inventory file cotains Ip addresses or hosnames, hostgroups variables and other config details.

Inventory files are typically written in INI format but YAML and JSON format are also supported.

Key point about inventories: 

- Host and groups: An inventory file typically consists of a list of hosts and their corresponding IP addresses or hostnames. Hosts can be grouped together to simplify the management of configurations. For example, you might have groups like "web_servers," "database_servers," and so on.
  ```
  [web_servers]
  web1 ansible_host=192.168.101
  web2 ansible_host=192.168.102

  [database_servers]
  db1 ansible_host=192.168.1.201
  ```
- Variables: can be used to castomize behavior of Ansible tasks for specific hosts or groups

  ```
  [web_servers]
  web1 ansible_host=192.168.1.101 ansible_user=myuser ansible_port=22

  [database_servers]
  db1 ansible_host=192.168.1.201 ansible_user=dbuser ansible_port=22

  ```
- Dynamic inventories: can be scripts or programs that generate inventory info dynamically based on external sources i.e cloud providers or db e.t.c


The default inventory file location is `/etc/ansible/hosts`, but you can specify a different file using `-i` option with the ansiblecommand.

Example:
```bash
 ansible -i inventory.ini web_servers -m ping
```

## Ansible Modules

These are small units of code that Ansible uses to perform tasks on managed hosts i.e installing software, copying files and managing services

[Ansible modules](https://docs.ansible.com/ansible/2.8/user_guide/modules.html) are `indempondent` i.e they can be run multiple times without changing the result of the initial execution

Standard Modules include:
 - **ping** - checks if host is reachable
 - **yum** or **apt** - installs or removes pckages in linux
 - **copy** - copies files to remote hosts
 - **file** - manages files and directories
 - **service** - manages services on target hosts

## Automate
## Repeat
