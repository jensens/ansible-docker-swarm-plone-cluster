# this is the user to connect to the host
ANSIBLE_SERVER_USER=root

.DEFAULT_GOAL := swarm-cluster

key-scan: hosts
	ansible-playbook -i hosts ssh-keyscan.yml
	touch .sentinel-keyscan

.PHONY: swarm-cluster
swarm-cluster: .sentinel-keyscan
	ansible-playbook -i hosts swarm-bootstrap.yml -u ${ANSIBLE_SERVER_USER} -e @extra-vars.yml