#!/usr/bin/env bash

set -xe

HOSTNAME=$1
IMAGE_DIR="/var/lib/libvirt/images"
CENTOS_BASEIMAGE="packer-centos7.qcow2"


if [ $# -eq 0 ]; then
    echo "Provide hostname"
    exit 1
fi


# todo: add a check here for if disk already exists as to not overwrite and exit
if [[ -f "$IMAGE_DIR/$CENTOS_BASEIMAGE" ]]
then
	cp "$IMAGE_DIR/$CENTOS_BASEIMAGE" "$IMAGE_DIR/$HOSTNAME".qcow2
else
	echo "No base image found" && exit 1
fi

virt-install \
--name $HOSTNAME \
--noautoconsole \
--os-type linux \
--os-variant "centos7.0" \
--vcpus 2 \
--memory 1024 \
--disk "$IMAGE_DIR/$HOSTNAME".qcow2 \
--import

# Sysprep newly created node - including update and firstboot script.
virt-sysprep --domain $HOSTNAME \
--hostname $HOSTNAME \
--operations defaults \
--operations -cron-spool,-package-manager-cache \

exit 0
