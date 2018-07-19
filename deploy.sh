#!/usr/bin/env bash

# Author: Jackson
# Function: Deploy KVM node from template

set -xe

HOSTNAME=$1
OS=$2

display_usage() {
    echo -e '\nUsage: This script requires two arguments - hostname and OS of the VM to be deployed\n\nE.g. bash deploy.sh test-machine centos\n'
}

if [ $# -eq 0 ]; then
    display_usage
    exit 1
fi

# Create new node from template
virt-clone \
--original-xml /vault/kvm-vm-templates/$OS-template.xml \
--name $HOSTNAME \
--file /vault/kvm-vm-storage/$HOSTNAME.qcow2

# Sysprep newly created node - including update and firstboot script.
virt-sysprep --domain $HOSTNAME \
--hostname $HOSTNAME \
--operations defaults \
--operations -cron-spool,-package-manager-cache \
--firstboot /vault/kvm-vm-templates/$OS-firstboot.sh

# Start node
virsh start $HOSTNAME

exit 0