# this is the user to connect to the host
ANSIBLE_SERVER_USER=root

.DEFAULT_GOAL := swarm-cluster

HOSTGROUP?=d01

key-scan: hosts
	ansible-playbook -i hosts.${HOSTGROUP} ssh-keyscan.yml
	touch .sentinel-keyscan

.PHONY: swarm-cluster
swarm-cluster: .sentinel-keyscan
	ansible-playbook -i hosts.${HOSTGROUP} swarm-bootstrap.yml -e @extra-vars-${HOSTGROUP}.yml
