#!/bin/bash
# Author: Jackson Hughes
# Function: Deploy KVM VMs from template

HOSTNAME=$1
VMNAME=$1 | awk '{print toupper($0)}'

# Clone new VM from template

virt-clone \
#--connect $KVM_HYPERVISOR
--original centos7-template \
--name $VMNAME \
--file /kvm-vm-storage/$1.qcow2

virt-sysprep \
#--connect $KVM_HYPERVISOR
--domain $VMNAME \
--colours \
--network \
--hostname $1 \
--update

virsh start $VMNAME
