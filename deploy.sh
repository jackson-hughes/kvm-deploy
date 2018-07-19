#!/usr/bin/env bash

# Author: Jackson
# Function: Deploy KVM node from template

set -xe

HOSTNAME=$1
FIRSTBOOTSCRIPT=/vault/kvm-vm-templates/script.sh

display_usage() {
    echo -e '\nUsage: This script requires two arguments - hostname and OS of the VM to be deployed\n\nE.g. bash deploy.sh test-machine centos\n'
}

if [ $# -eq 0 ]; then
    display_usage
    exit 1
fi

if [ "$2" == 'centos' ]; then
    TEMPLATE='centos7-template'
elif [ "$2" == 'ubuntu' ]; then
    TEMPLATE='ubuntu16.04-template'
else
    display_usage
    exit1
fi

# Create new node from template
virt-clone \
--original-xml /vault/kvm-vm-templates/$TEMPLATE.xml \
--name $HOSTNAME \
--file /vault/kvm-vm-storage/$HOSTNAME.qcow2

# Sysprep newly created node - including update and firstboot script.
virt-sysprep --domain $HOSTNAME \
--hostname $HOSTNAME \
--operations defaults \
--operations -cron-spool,-package-manager-cache \
--firstboot /vault/kvm-vm-templates/script.sh

# Start node
virsh start $HOSTNAME

exit 0