# Ansible Docker Swarm Plone CMS Cluster

**Special version for AkBild**

Create and deploy an n-node docker swarm cluster in minutes, with

- [Traefik](https://containo.us/traefik/) as a reverse proxy and load balancer, including LetsEncrypt TLS certificates,
- [Portainer](https://www.portainer.io/) to manage containers and

## Prerequisites

- [Ansible](https://www.ansible.com/) on local maschine
- One or more servers running Debian 11 connected through a private network (VMWare)
- SSH access to these servers using your public key. The user has to be able to do sudo w/o password.

## Preparation

First clone this repo to your local machine

Then
- copy the `hosts.example` file as `hosts` and edit it by replacing the ip of your main server and replacing/adding as many nodes as you wish to join your server (if just starting you can just have your main server and add nodes later on).
- create an `extra-vars.yml` using the `extra-vars.example.yml` as a guide.
- if you do not connect as root to the server (recommended!) edit the Makefile and set the user to connect to the servers for use with Ansible.

## Running

Once all is prepared you can run all the required commands using the provided `Makefile` that will launch the appropiate playbook:

```bash
make
```

This command will start running the imported playbooks in the order they appear:

```ansible
- import_playbook: docker-dependencies.yml
- import_playbook: main.yml
- import_playbook: workers.yml
- import_playbook: traefik/traefik.yml
- import_playbook: portainer/portainer.yml

```

After a couple minutes the cluster will be up and initialized and ansible will start to install traefik and the other services asking a prompt for user, password and email (for traefik), and for the domain names for all three services (to use with traefik reverse proxy). Make sure you point these (sub)domains to the main's public ip address.

A couple of more minutes and you should have your cluster up and running.

## Initial Steps

- Portainer initially shows a page at the root of the configured domain to set your administrator password. Go there immediatly and set it.

## Acknowledgement

This is a fork of https://github.com/rodrigoegimenez/ansible-docker-swarm-cluster - thanks @rodrigoegimenez for these foundation!

This idea is heavily influenced by [Docker Swarm Rocks](https://dockerswarm.rocks/). Traefik and portainer's compose files were obtained from this guide.

Another source of inspiration, specially for the ansible part, was [this](https://www.digitalocean.com/community/tutorials/how-to-create-a-kubernetes-cluster-using-kubeadm-on-ubuntu-18-04) DigitalOcean's guide to create a Kubernetes Cluster.
