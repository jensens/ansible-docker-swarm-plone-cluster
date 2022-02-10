# this is the user to connect to the host
ANSIBLE_SERVER_USER=root

.DEFAULT_GOAL := swarm-cluster

HOSTFILE?=hosts.test

key-scan: hosts
	ansible-playbook -i ${HOSTFILE} ssh-keyscan.yml
	touch .sentinel-keyscan

.PHONY: swarm-cluster
swarm-cluster: .sentinel-keyscan
	ansible-playbook -i ${HOSTFILE} swarm-bootstrap.yml -e @extra-vars-d01.yml