#!/bin/bash

DOMAIN_NAME=${DOMAIN_NAME:-$(dnsdomainname)}
MASTER_HOSTNAME=${MASTER_HOSTNAME:-openshiftv14}
MASTER_FULL_HOSTNAME=${MASTER_HOSTNAME}.${DOMAIN_NAME}

if [[ -f hosts.origin.inventory ]]; then
	sed "s/openshiftv14.test.example.com/${MASTER_FULL_HOSTNAME}/g" \
	"s/test.example.com/${DOMAIN_NAME}/g" \
	"s/openshiftv14/${MASTER_HOSTNAME}/g" \
	hosts.origin.template > hosts.origin.inventory
fi

RPM_VERSION=3.4.59-2.git.2.76c5698.el7

sudo yum install -y docker
sudo systemctl enable docker
sudo systemctl start docker

sudo yum install -y centos-release-openshift-origin14
sudo yum install -y openshift-ansible-${RPM_VERSION} \
openshift-ansible-*-${RPM_VERSION}
sudo yum downgrade -y python2-passlib-1.6.5

sudo ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/byo/config.yml -i hosts.origin.inventory

sudo oadm policy add-role-to-user admin admin
sudo oadm policy add-cluster-role-to-user cluster-admin admin
sudo oadm policy add-role-to-user hawkular-metrics-admin admin
sudo oadm policy add-role-to-user management-infra-admin admin
sudo oadm policy add-role-to-user registry-admin admin
sudo oadm policy add-role-to-user storage-admin admin
