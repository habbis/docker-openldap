# debian based openldap container WIP




[![CI](https://github.com/habbis/docker-openldap/workflows/Build/badge.svg?branch=main&event=push)](https://github.com/habbis/docker-openldap/actions?query=workflow%3ABuild) [![Docker pulls](https://img.shields.io/docker/pulls/habbis0/docker-openldap)](https://hub.docker.com/r/habbis0/docker-openldap/)

openldap Docker container.

## Tags

  - `latest`: Latest version of debian unstable package of openldap


## How to Build

This image is built on Docker Hub automatically any time the upstream OS container is rebuilt, and any time a commit is made or merged to the `master` branch. But if you need to build the image on your own locally, do the following:

  1. [Install Docker](https://docs.docker.com/install/).
  2. `cd` into this directory.
  3. Run `docker build -t ubuntu2004-ansible .`

## How to Use

  1. [Install Docker](https://docs.docker.com/engine/installation/).
  2. Pull this image from Docker Hub: `docker pull habbis/docker-openldap:latest` (or use the image you built earlier, e.g. `ubuntu2004-ansible:latest`).
  3. Run a container from the image: `docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro habbis/docker-openldap:latest` (to test my Ansible roles, I add in a volume mounted from the current working directory with ``--volume=`pwd`:/etc/ansible/roles/role_under_test:ro``).
  4. Use Ansible inside the container:
    a. `docker exec --tty [container_id] env TERM=xterm ansible --version`
    b. `docker exec --tty [container_id] env TERM=xterm ansible-playbook /path/to/ansible/playbook.yml --syntax-check`

## Notes

WIP

> **Important Note**: WIP . Use on production servers/in the wild at your own risk!


