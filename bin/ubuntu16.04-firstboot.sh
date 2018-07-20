#!/usr/bin/env bash

systemctl start networking
dpkg-reconfigure openssh-server
apt-get update -y && apt full-upgrade -y