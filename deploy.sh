#!/usr/bin/env bash

# Author: Jackson
# Function: Deploy KVM node from template

HOSTNAME=$1

# Initialise ZFS dataset for new node

# Create new node from template
virt-clone \
--original \
--name $HOSTNAME \
--file /vault/kvm-vm-storage/$HOSTNAME.qcow2

# Sysprep newly created node - including update and firstboot script. 
virt-sysprep \
--domain $HOSTNAME \
--colours \
--hostname $HOSTNAME \
--firstboot

 
# Start node
virsh start $HOSTNAME  