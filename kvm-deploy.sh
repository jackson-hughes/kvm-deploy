#!/bin/bash
# Author: Jackson Hughes
# Function: Deploy KVM VMs from template

HOSTNAME=$1

# Clone new VM from template

virt-clone \
--original centos7-template \
--name $HOSTNAME \
--file /kvm-vm-storage/$HOSTNAME.qcow2

virt-sysprep \
--domain $HOSTNAME \
--colours \
--network \
--hostname $HOSTNAME \
--update

virsh start $HOSTNAME
